local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fp', extensions.projects.projects, {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
