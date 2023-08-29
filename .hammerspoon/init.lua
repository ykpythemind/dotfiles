function focus(appName)
  local app = hs.application.get(appName)

  if app ~= nil then
    hs.application.launchOrFocus(appName)
    --app:hide()
  else
    hs.application.launchOrFocus(appName)
  end
end

hs.hotkey.bind({ "ctrl" }, "1", function()
  focus("Sidekick")
end)
hs.hotkey.bind({ "ctrl" }, "2", function()
  focus("Terminal")
end)
hs.hotkey.bind({ "ctrl" }, "3", function()
  focus("Visual Studio Code")
end)
