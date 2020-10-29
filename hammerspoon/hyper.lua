-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, 'F17')

triggerHyperAction = function()
  k.triggered = true
end

-- Launch or Focus an App
launch = function(appname)
  hs.application.launchOrFocus(appname)
  triggerHyperAction()
end

ableton = 'Ableton Live 10.1.3 Suite'
flstudio = 'FL Studio 20'
bitwig = 'Bitwig Studio'
daw1 = ableton
daw2 = flstudio
daw3 = bitwig

mainApp = 'iTerm'

-- Single keybinding for app launch
singleapps = {
  {'-', '/Applications/Utilities/Console.app'},
  {'=', 'Activity Monitor'},
  {'\\', daw2},
  {']', daw3},
  {'1', '1Password'},
  {'2', 'Kindle'},
  {'a', ableton},
  {'b', 'Google Chrome Canary'},
  {'c', '/Applications/Universal Audio/Console.app'},
  {'d', 'Dash'},
  {'e', 'Spark'},
  {'f', 'Finder'},
  {'h', 'Postman'},
  -- pressing k in vim toggles HYPER-k too often  
  {'l', 'Logic Pro X'},
  {'m', 'Messages'},
  {'p', 'Preview'},
  {'q', 'Spotify'},
  {'r', 'Vitamin-R 3'},
  {'s', 'Splice'},
  {'t', 'Samplism'},
  {'u', 'Music'},
  {'v', 'VLC'},
  {'w', 'Microsoft To Do'},
  {'x', 'Xcode'},
  {'return', 'Google Chrome'},
  {'space', mainApp}
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

