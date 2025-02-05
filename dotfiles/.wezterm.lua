-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action


-- For example, changing the color scheme:
config.color_scheme = 'Smyck (Gogh)'
-- config.color_scheme = 'Mariana'
-- config.color_scheme = 'Material (base16)'
-- config.color_scheme = 'Material Darker (base16)'
-- config.color_scheme = 'Seti UI (base16)'


-- Remove padding between text and window edge
config.window_padding = {
  left = 2,
  right = 2,
  top = 0,
  bottom = 0,
}


-- Cmd+K clears everything
config.keys = {
  {
    key = 'k',
    mods = 'CMD',
    action = act.ClearScrollback "ScrollbackAndViewport"
  },
}

-- e.g. Ctrl+Alt+1 to move tab to 1st position
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = wezterm.action.MoveTab(i - 1),
  })
end

return config
