-- 42 header
vim.g['user42'] = 'nfaivre'
vim.g['mail42'] = 'nfaivre@student.42.fr'
-- 42 header

-- neovide
if vim.g['neovide'] then -- check if in neovide
	vim.g['neovide_refresh_rate'] = '60' -- might want to set it to something like 30 to increase battery life
	vim.g['neovide_refresh_rate_idle'] = '5'
	vim.g['neovide_fullscreen'] = 'true'
end
-- neovide

-- ale
vim.g['ale_completion_enabled'] = '0'
-- ale
