return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    hidden = true
                }
            },
            defaults = {
                file_ignore_patterns = { ".git/", "node_modules/", ".cache/" },
                layout_config = {
                    horizontal = { width = 0.95 },
                },
                path_display = { "smart" }
            },
        })
        -- Keybindings
        vim.api.nvim_set_keymap("", "?", "<cmd>Telescope find_files<CR>", { noremap = true, desc = "Find files" })
        vim.api.nvim_set_keymap("", "'", "<cmd>Telescope live_grep<CR>", { noremap = true, desc = "Live grep" })
        vim.api.nvim_set_keymap("", "<leader>sr", "<cmd>Telescope oldfiles<CR>", { noremap = true, desc = "Old files" })
    end,
}

