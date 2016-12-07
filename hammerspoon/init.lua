
-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- Launch or Focus an App
launch = function(appname)
  hs.application.launchOrFocus(appname)
  k.triggered = true
end

-- Single keybinding for app launch
singleapps = {
  {'b', 'Google Chrome Canary'},
  {'c', 'Slack'},
  {'d', 'Dash'},
  {'e', 'Airmail 2'},
  {'h', 'Plug'},
  {'m', 'Messages'},
  {'p', 'Pandora'},
  {'r', 'Vitamin-R 2'},
  {'t', 'Tidal'},
  {'w', 'Wunderlist'},
  {'x', 'Xcode'},
  {'return', 'Google Chrome'},
  {'space', '/Applications/iTerm.app'}
}
for i, app in ipairs(singleapps) do
  k:bind({}, app[1], function() launch(app[2]); end)
end

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- ^w deletes a word
hs.hotkey.bind({'ctrl'}, 'w', nil, function() hs.eventtap.keyStroke({'alt'}, 'delete'); end)
