function focus(appName)
  local app = hs.application.get(appName)

  if app ~= nil then
    hs.application.launchOrFocus(appName)
    --app:hide()
  else
    hs.application.launchOrFocus(appName)
  end
end

hs.hotkey.bind({ "cmd" }, "1", function()
  focus("Sidekick")
end)
hs.hotkey.bind({ "cmd" }, "2", function()
  focus("Terminal")
end)
hs.hotkey.bind({ "cmd" }, "3", function()
  focus("Visual Studio Code")
end)
