return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2",
    event = "VimEnter",
    build = "<cmd>TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "java", "lua", "vim", "vimdoc", "javascript", "html", "tsx", "typescript", "yaml", "python" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
}

