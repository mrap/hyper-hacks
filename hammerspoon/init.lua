
-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

triggerHyperAction = function()
  k.triggered = true
end

-- Launch or Focus an App
launch = function(appname)
  hs.application.launchOrFocus(appname)
  triggerHyperAction()
end

-- Single keybinding for app launch
singleapps = {
  {'1', '1Password'},
  {'b', 'Google Chrome Canary'},
  {'c', 'Slack'},
  {'d', 'Dash'},
  {'e', 'Newton'},
  {'f', 'Finder'},
  {'h', 'Plug'},
  {'m', 'Messages'},
  {'p', 'Preview'},
  {'r', 'Vitamin-R 2'},
  {'t', 'Spotify'},
  {'w', 'Wunderlist'},
  {'x', 'Xcode'},
  {'return', 'Google Chrome'},
  {'space', '/Applications/iTerm.app'}
}
for i, app in ipairs(singleapps) do
  k:bind({}, app[1], function() launch(app[2]); end)
end

-- Hyper+/ app help menu
k:bind({}, '/', nil, function() triggerHyperAction() hs.eventtap.keyStroke({'cmd', 'shift'}, '/'); end)

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
