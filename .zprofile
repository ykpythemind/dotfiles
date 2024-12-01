
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh --shims)"
elif; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi
