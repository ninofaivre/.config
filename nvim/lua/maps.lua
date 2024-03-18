vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

local function cmd(str)
	return '<cmd>' .. str .. '<cr>'
end

vim.keymap.set('n', '<c-t>', cmd('tabnew'), opts)
vim.keymap.set('n', '<c-c>', cmd('close'), opts)
vim.keymap.set('n', '<c-h>', cmd('tabprev'), opts)
vim.keymap.set('n', '<c-l>', cmd('tabnext'), opts)

vim.keymap.set('n', '<c-ù>', cmd('source'), opts)

-- TODO faire une commande qui override :w pour strip out ù et m'afficher quelque chose de rigolo
vim.keymap.set('ia', 'nvide', 'neovide')
