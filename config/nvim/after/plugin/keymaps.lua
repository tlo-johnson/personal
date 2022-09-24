local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("t", "\\\\", "<C-\\><C-n>", default_opts)

-- Navigate splits
keymap("n", "<c-h>", "<c-w>h", default_opts)
keymap("n", "<c-t>", "<c-w>j", default_opts)
keymap("n", "<c-n>", "<c-w>k", default_opts)
keymap("n", "<c-s>", "<c-w>l", default_opts)
keymap("t", "<c-h>", "<c-\\><c-n><c-w>h", default_opts)
keymap("t", "<c-t>", "<c-\\><c-n><c-w>j", default_opts)
keymap("t", "<c-n>", "<c-\\><c-n><c-w>k", default_opts)
keymap("t", "<c-s>", "<c-\\><c-n><c-w>l", default_opts)
