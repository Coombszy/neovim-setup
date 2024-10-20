local map = vim.api.nvim_set_keymap

-- Navigation
map("", "h", "<Up>", {})
map("", "j", "<Down>", {})
map("", "k", "<Left>", {})
map("", "l", "<Right>", {})
map("", "<leader>l", "<cmd>b#<CR>", { desc = "Open last buffer" })

--Window navigation
----hjkl
map("", "<C-h>", "<C-w><Up>", {})
map("", "<C-j>", "<C-w><Down>", {})
map("", "<C-k>", "<C-w><Left>", {})
map("", "<C-l>", "<C-w><Right>", {})
map("", "<C-S-k>", "<cmd>tabprev<CR>", {})
map("", "<C-S-l>", "<cmd>tabnext<CR>", {})
----Arrows
map("", "<C-Up>", "<C-w><Up>", {})
map("", "<C-Down>", "<C-w><Down>", {})
map("", "<C-Left>", "<C-w><Left>", {})
map("", "<C-Right>", "<C-w><Right>", {})
map("", "<C-S-Left>", "<cmd>tabprev<CR>", {})
map("", "<C-S-Right>", "<cmd>tabnext<CR>", {})

--Toggles
map("", "<C-l>", "<cmd>set relativenumber!<CR>", {})

-- Disable
map("", "<F1>", "<Nop>", {})
map("", "<C-[>", "<Nop>", {})
map("", "<C-]>", "<Nop>", {})

