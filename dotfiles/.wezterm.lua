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

config.keys = {
  {
    key = 'k',
    mods = 'CMD',
    action = act.ClearScrollback "ScrollbackAndViewport"
  },
}

return config
