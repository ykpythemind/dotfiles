#!/usr/bin/env ruby
# frozen_string_literal: true

# Convert Claude Code JSONL conversation logs to readable Markdown.

require "json"
require "optparse"

module ClaudeLogToMd
  module_function

  def load_entries(path)
    File.readlines(path).filter_map do |line|
      line = line.strip
      JSON.parse(line) unless line.empty?
    end
  end

  def build_chain(entries)
    by_uuid = {}
    roots = []
    children = Hash.new { |h, k| h[k] = [] }

    entries.each do |e|
      uuid = e["uuid"]
      parent = e["parentUuid"]
      by_uuid[uuid] = e if uuid
      if parent
        children[parent] << uuid
      else
        roots << e
      end
    end

    ordered = []
    visited = Set.new

    walk = ->(uuid) {
      return if visited.include?(uuid)
      visited.add(uuid)
      ordered << by_uuid[uuid] if by_uuid.key?(uuid)
      children[uuid]&.each { |child| walk.call(child) }
    }

    roots.each do |r|
      uuid = r["uuid"]
      if uuid
        walk.call(uuid)
      else
        ordered << r
      end
    end

    # Add orphans
    entries.each { |e| ordered << e unless ordered.include?(e) }

    ordered
  end

  def truncate(text, max_len)
    return text if text.nil? || text.length <= max_len
    text[0, max_len] + "\n...(truncated)"
  end

  def format_tool_use(block, max_input_len = 1000)
    name = block["name"] || "unknown"
    input_str = JSON.pretty_generate(block["input"] || {})
    input_str = truncate(input_str, max_input_len)
    "**Tool: #{name}**\n```json\n#{input_str}\n```"
  end

  def format_tool_result(block, max_result_len)
    is_error = block["is_error"]
    content = block["content"] || ""
    if content.is_a?(Array)
      content = content.map { |c|
        c.is_a?(Hash) ? (c["text"] || c.to_s) : c.to_s
      }.join("\n")
    end
    content = truncate(content.to_s, max_result_len)
    label = is_error ? "Error" : "Result"
    "**#{label}:**\n```\n#{content}\n```"
  end

  def format_entry(entry, include_thinking:, max_content_len:)
    entry_type = entry["type"]
    msg = entry["message"] || {}
    role = msg["role"] || ""
    content = msg["content"]

    return nil if %w[file-history-snapshot progress system].include?(entry_type)
    return nil if content.nil? || (content.respond_to?(:empty?) && content.empty?)

    parts = []

    if content.is_a?(String)
      case role
      when "user"
        parts << "## Human\n\n#{truncate(content, max_content_len)}"
      when "assistant"
        parts << "## Assistant\n\n#{truncate(content, max_content_len)}"
      end
      return parts.empty? ? nil : parts.join("\n")
    end

    if content.is_a?(Array)
      content.each do |block|
        case block["type"]
        when "thinking"
          if include_thinking
            thinking_text = truncate(block["thinking"] || "", max_content_len)
            parts << "<details>\n<summary>Thinking</summary>\n\n#{thinking_text}\n\n</details>"
          end
        when "text"
          text = block["text"] || ""
          parts << truncate(text, max_content_len) unless text.strip.empty?
        when "tool_use"
          parts << format_tool_use(block)
        when "tool_result"
          parts << format_tool_result(block, max_content_len)
        end
      end
    end

    parts.empty? ? nil : parts.join("\n\n")
  end

  def convert(path, include_thinking: false, max_content_len: 2000)
    entries = load_entries(path)
    chain = build_chain(entries)

    session_id = nil
    timestamp = nil
    cwd = nil

    chain.each do |e|
      session_id ||= e["sessionId"]
      timestamp ||= e["timestamp"]
      cwd ||= e["cwd"]
      break if session_id && timestamp && cwd
    end

    lines = []
    lines << "# Claude Code Session"

    meta = []
    meta << "- **Session**: `#{session_id}`" if session_id
    meta << "- **Started**: #{timestamp}" if timestamp
    meta << "- **Working Directory**: `#{cwd}`" if cwd
    lines << meta.join("\n") unless meta.empty?

    lines << "---"

    current_role = nil

    chain.each do |entry|
      entry_type = entry["type"]
      msg = entry["message"] || {}
      role = msg["role"] || ""
      content = msg["content"]

      next if %w[file-history-snapshot progress system].include?(entry_type)
      next if content.nil? || (content.respond_to?(:empty?) && content.empty?)

      if !role.empty? && role != current_role
        case role
        when "user"
          is_tool_result = content.is_a?(Array) && content.all? { |c| c["type"] == "tool_result" }
          unless is_tool_result
            lines << "\n## Human\n"
            current_role = role
          end
        when "assistant"
          lines << "\n## Assistant\n"
          current_role = role
        end
      end

      formatted = format_entry(entry, include_thinking: include_thinking, max_content_len: max_content_len)
      if formatted
        formatted = formatted.gsub("## Human\n\n", "").gsub("## Assistant\n\n", "")
        lines << formatted
      end
    end

    lines.join("\n\n")
  end

  def find_latest_session(project_path = nil)
    claude_dir = File.expand_path("~/.claude/projects")
    return nil unless Dir.exist?(claude_dir)

    if project_path
      normalized = project_path.gsub("/", "-")
      project_dir = File.join(claude_dir, normalized)
      return nil unless Dir.exist?(project_dir)
      search_dirs = [project_dir]
    else
      search_dirs = Dir.children(claude_dir)
        .map { |d| File.join(claude_dir, d) }
        .select { |d| File.directory?(d) }
    end

    latest = nil
    latest_mtime = 0

    search_dirs.each do |d|
      Dir.glob(File.join(d, "*.jsonl")).each do |f|
        mtime = File.mtime(f).to_f
        if mtime > latest_mtime
          latest_mtime = mtime
          latest = f
        end
      end
    end

    latest
  end
end

if __FILE__ == $0
  options = {
    thinking: false,
    max_len: 2000,
    no_truncate: false,
    project: nil,
  }

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [OPTIONS] [FILE]"

    opts.on("--thinking", "Include thinking blocks (collapsed in <details>)") do
      options[:thinking] = true
    end

    opts.on("--max-len N", Integer, "Max characters per content block (default: 2000)") do |n|
      options[:max_len] = n
    end

    opts.on("--no-truncate", "Disable truncation of long content") do
      options[:no_truncate] = true
    end

    opts.on("--project PATH", "Project path to find sessions for") do |p|
      options[:project] = p
    end

    opts.on("-h", "--help", "Show this help") do
      puts opts
      exit
    end
  end

  parser.parse!
  file = ARGV[0]

  max_len = options[:no_truncate] ? Float::INFINITY : options[:max_len]

  if file
    path = file
  else
    path = ClaudeLogToMd.find_latest_session(options[:project])
    if path.nil?
      warn "Error: No session file found. Specify a file path."
      exit 1
    end
    warn "Using: #{path}"
  end

  unless File.file?(path)
    warn "Error: File not found: #{path}"
    exit 1
  end

  puts ClaudeLogToMd.convert(path, include_thinking: options[:thinking], max_content_len: max_len)
end
