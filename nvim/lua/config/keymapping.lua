local map = vim.api.nvim_set_keymap

-- Navigation
map("", "<leader>l", "<cmd>b#<CR>", { desc = "Open last buffer" })

--Window navigation
----hjkl
map("", "<C-h>", "<C-w><Left>", {})
map("", "<C-j>", "<C-w><Down>", {})
map("", "<C-k>", "<C-w><Up>", {})
map("", "<C-l>", "<C-w><Right>", {})
map("", "<C-S-h>", "<cmd>tabprev<CR>", {})
map("", "<C-S-l>", "<cmd>tabnext<CR>", {})
----Arrows
map("", "<C-Up>", "<C-w><Up>", {})
map("", "<C-Down>", "<C-w><Down>", {})
map("", "<C-Left>", "<C-w><Left>", {})
map("", "<C-Right>", "<C-w><Right>", {})
map("", "<C-S-Left>", "<cmd>tabprev<CR>", {})
map("", "<C-S-Right>", "<cmd>tabnext<CR>", {})

--Toggles
map("", "<C-S-l>", "<cmd>set relativenumber!<CR>", {})

-- Disable
map("", "<F1>", "<Nop>", {})

