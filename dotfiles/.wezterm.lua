-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Mariana'
-- config.color_scheme = 'Material (base16)'
-- config.color_scheme = 'Material Darker (base16)'
-- config.color_scheme = 'Seti UI (base16)'
config.color_scheme = 'Smyck (Gogh)'

config.keys = {
  {
    key = 'k',
    mods = 'CMD',
    action = act.ClearScrollback "ScrollbackAndViewport"
  },
}

-- and finally, return the configuration to wezterm
return config
