local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
config.color_scheme = 'Catppuccin Macchiato'
-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font = wezterm.font('FiraCode Nerd Font Mono')
config.font_size = 14.0

config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 100000
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 700
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'


return config
