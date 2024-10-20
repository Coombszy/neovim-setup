return {

    -- LSP Config (nvim-lspconfig)
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile", "BufEnter", "BufNew" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            {
                "nvim-java/nvim-java",
                tag = "2.0.1"
            }
        },
        config = function()
            require('java').setup()
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local bmap = vim.api.nvim_buf_set_keymap
            local opts = { noremap = true, silent = true }

            -- b is the buffer id
            local callback = function(_, b)
                -- keybinds, if LSP attached to buffer
                opts.desc = "Show LSP references"
                bmap(b, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
                opts.desc = "Go to declaration"
                bmap(b, "n", "gD", "<cmd>lua vim.lsp.buf.declaration<CR>", opts)
                opts.desc = "Show LSP definitions"
                bmap(b, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                opts.desc = "Show LSP implementations"
                bmap(b, "n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                opts.desc = "Show LSP type definitions"
                bmap(b, "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                opts.desc = "Next diagnostic"
                bmap(b, "n", "g<Down>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
                opts.desc = "Previous diagnostic"
                bmap(b, "n", "g<Up>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
                opts.desc = "LSP Format"
                bmap(b, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
                opts.desc = "See available code actions"
                bmap(b, "n", "<leader>a", "<leader>ca", opts)
                opts.desc = "Smart rename"
                bmap(b, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename<CR>", opts)
                opts.desc = "Show documentation under cursor"
                bmap(b, "n", "K", "<cmd>lua vim.lsp.buf.hover<CR>", opts)
                opts.desc = "Restart LSP"
                bmap(b, "n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
            end

            -- Enable autocompletion
            local cap = cmp_nvim_lsp.default_capabilities()

            -- Configure LSP servers
            lspconfig["jdtls"].setup { capabilities = cap, on_attach = callback }
            lspconfig["java"].setup { capabilities = cap, on_attach = callback }
        end,
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        event = "VimEnter",
        tag = "stable",
        dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "ts_ls", "terraformls", "tflint", "pyright" },
                automatic_installation = true, -- Auto install servers that are configured, but not ensured
            }
        end
    },

    -- Auto completion (nvim-cmp)
    {
        "hrsh7th/nvim-cmp",
        -- tag = "", -- None suitable
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",           -- source from buffer
            "hrsh7th/cmp-path",             -- source from file system paths
            "L3MON4D3/LuaSnip",             -- snippet engine
            "rafamadriz/friendly-snippets", -- generic snippet collection
            "saadparwaiz1/cmp_luasnip",     -- source from snippet engine
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Load generic snippets (friendly-snippets)
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                snippet = {
                    -- Interact with snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<F4>"] = cmp.mapping.complete(),                  -- Show suggestions
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Confirm suggestion
                    ["<C-PageDown>"] = cmp.mapping.scroll_docs(2),      -- Scroll docs down
                    ["<C-PageUp>"] = cmp.mapping.scroll_docs(-2),       -- Scroll docs up
                }),
                -- All sources for completion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSP servers
                    { name = "luasnip" },  -- snippets
                    { name = "buffer" },   -- text in current buffer
                    { name = "path" },     -- file system paths
                }),
            })
        end
    },
}
