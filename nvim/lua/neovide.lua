-- config applies only if in neovide
if vim.g.neovide == nil then
	return
end

vim.o.guifont = "Fira Code,FiraCode Nerd Font:h10"
vim.g.neovide_scroll_animation_length = 0.15
vim.g.neovide_hide_mouse_when_typing = true

-- desktop probably wants vsync anyway
-- laptop probably doesn't wants vsync so it can lower it based
-- on battery percentage, increase if it is plugged in the power
-- lower idle_refresh_rate too mb ?
-- vim.g.neovide_refresh_rate
-- for laptop too
-- vim.g.neovide_touch_deadzone = 6.0
-- vim.g.neovide_touch_drag_timeout = 0.17

vim.g.neovide_no_idle = false
vim.g.neovide_confirm_quit = false
vim.g.neovide_fullscreen = false
vim.g.neovide_profiler = false
vim.g.neovide_cursor_animation_length = 0.07
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_vfx_mode	= "ripple"
