return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.3",
    event = "VeryLazy",
    build = "<cmd>TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "lua", "vim", "vimdoc", "yaml" },
            auto_install = true,
            highlight = { enable = true },
        })
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
}
