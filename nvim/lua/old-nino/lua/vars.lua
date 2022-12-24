-- 42 header
vim.g['42user'] = 'nfaivre'
vim.g['42mail'] = 'nfaivre@student.42.fr'
vim.g['countryCode'] = 'zz'
vim.g['commentTable'] =
{
	["<3"]	= { start = "<3", fill = "=", ["end"] = "<3", ["width"] = 200 },
	test	= { start = "te", fill = "-", ["end"] = "st" }
}
vim.g['42HeaderWidth'] = 120
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
