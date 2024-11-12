vim.g.mapleader = " "

vim.keymap.set('n', '<leader>qo', '<cmd>copen<cr>', {desc = "Open quickfix list"})
vim.keymap.set('n', '<leader>qw', '<cmd>cprev<cr>', {desc = "Previous quickfix"})
vim.keymap.set('n', '<leader>qe', '<cmd>cnext<cr>', {desc = "Next quickfix"})
vim.keymap.set('n', '<leader>qp', '<cmd>cclose<cr>', {desc = "Close quick fix"})
