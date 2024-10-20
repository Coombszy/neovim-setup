return {
    "famiu/feline.nvim",
    tag = "v1.1.3",
    event = "VimEnter",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
        local ctp_feline = require("catppuccin.groups.integrations.feline")
        ctp_feline.setup()
        require("gitsigns").setup()
        require("feline").setup({
            components = ctp_feline.get(),
        })
    end,
}
