return {
    "echasnovski/mini.nvim",
    version = "*", -- Latest stable
    event = "VimEnter",
    config = function()
        require("mini.files").setup({
            mappings = {
                close  = "<ESC>",
                -- Stop using arrow keys loser!
                -- go_in  = "<Right>",
                -- go_out = "<Left>",
            },
        })
        local mf = require("mini.files")
        function ToggleMiniFiles()
            if not mf.close() then
                mf.open()
            end
        end

        vim.api.nvim_set_keymap("n", "<F3>", "<cmd>lua ToggleMiniFiles()<CR>", { desc = "Toggle mini.files" })
    end,
}
