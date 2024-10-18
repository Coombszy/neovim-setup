-- © 2024 Liam Coombs <LCCoombs@hotmail.co.uk>
--------------------------------------------------------------------------------
-- Setup lazy package manager
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- Default configs
--------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.mouse = "a"
vim.opt.wildignore = vim.opt.wildignore + { "*.pyc", "node_modules", "_site", "__pycache__" }
vim.opt.showmode = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.g.have_nerd_font = true

--------------------------------------------------------------------------------
-- Vim Keybinds
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Install plugins
--------------------------------------------------------------------------------
-- Create a global state storage
State = {}

require("lazy").setup({

    -- Theme (catppuccin)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    treesitter = true,
                    cmp = true,
                    gitsigns = true,
                    mason = true,
                },
            })
            vim.cmd.colorscheme "catppuccin"
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        tag = "0.1.6",
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
                    }
                },
            })
            -- Keybindings
            map("", "?", "<cmd>Telescope find_files<CR>", { noremap = true, desc = "Find files" })
            map("", "'", "<cmd>Telescope live_grep<CR>", { noremap = true, desc = "Live grep" })
            map("", "<leader>sr", "<cmd>Telescope oldfiles<CR>", { noremap = true, desc = "Old files" })
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        tag = "v0.9.2",
        event = "VimEnter",
        build = "<cmd>TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "tsx", "typescript", "yaml", "python" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
    },

    -- LSP Config (nvim-lspconfig)
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile", "BufEnter", "BufNew" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
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
            lspconfig["tsserver"].setup { capabilities = cap, on_attach = callback }
            lspconfig["terraformls"].setup { capabilities = cap, on_attach = callback }
            lspconfig["tflint"].setup { capabilities = cap, on_attach = callback }
            lspconfig["pyright"].setup { capabilities = cap, on_attach = callback }
            lspconfig["lua_ls"].setup {
                capabilities = cap,
                on_attach = callback,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } } -- Hide undefined global error for `vim`
                    }
                }
            }
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
                ensure_installed = { "tsserver", "lua_ls", "terraformls", "tflint", "pyright" },
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

    -- Comment.nvim
    {
        "numToStr/Comment.nvim",
        tag = "v0.8.0",
        event = "VimEnter",
        config = function()
            require("Comment").setup()
        end
    },

    -- Neoscroll
    {
        "karb94/neoscroll.nvim",
        -- tag = "" -- None suitable
        event = "VimEnter",
        enabled = false, -- Disabled due to bug: https://github.com/karb94/neoscroll.nvim/issues/96
        config = function()
            require("neoscroll").setup({
                easing_function = "quadratic" -- Default easing function
            })

            local t    = {}
            t["<C-[>"] = { "scroll", { "-vim.wo.scroll", "true", "250" } }
            t["<C-]>"] = { "scroll", { "vim.wo.scroll", "true", "250" } }
            t["zt"]    = { "zt", { "250" } }
            t["zz"]    = { "zz", { "250" } }
            t["zb"]    = { "zb", { "250" } }
            -- Disabled
            -- t["<C-b>"] = {"scroll", {"-vim.api.nvim_win_get_height(0)", "true", "450"}}
            -- t["<C-f>"] = {"scroll", { "vim.api.nvim_win_get_height(0)", "true", "450"}}
            -- t["<C-y>"] = {"scroll", {"-0.10", "false", "100"}}
            -- t["<C-e>"] = {"scroll", { "0.10", "false", "100"}}
            require("neoscroll.config").set_mappings(t)
        end,
    },

    -- Mini.nvim
    {
        "echasnovski/mini.nvim",
        version = "*", -- Latest stable
        event = "VimEnter",
        config = function()
            require("mini.files").setup({
                mappings = {
                    close  = "<ESC>",
                    go_in  = "<Right>",
                    go_out = "<Left>",
                },
            })
            local mf = require("mini.files")
			function ToggleMiniFiles()
				if not mf.close() then
					mf.open()
				end
			end

            map("n", "<F3>", "<cmd>lua ToggleMiniFiles()<CR>", { desc = "Toggle mini.files" })
        end,
    },

    -- feline.nvim (Status bar)
    {
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
    },

    -- which-key
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 800
        end,
        opts = {},
    },

    -- vim-floaterm
    {
        "voldikss/vim-floaterm",
        -- tag = "", -- None suitable
        event = "VimEnter",
        config = function()
            local g = vim.g
            g.floaterm_title = "Terminal"
            -- Float: Percent of window width, Integer: Num of columns
            g.floaterm_width = 0.999 -- Lua convets 1.0 to 1, which is then 1 column
            g.floaterm_height = 0.34
            g.floaterm_position = "bottom"
            map("n", "<F2>", "<cmd>FloatermToggle<CR>", { desc = "Toggle float term" })
            map("i", "<F2>", "<ESC><cmd>FloatermToggle<CR>", { desc = "Toggle float term" })
            map("t", "<F2>", "<C-\\><C-n><cmd>FloatermToggle<CR>", { desc = "Toggle float term" })
        end,
    },

    -- diffview
    {
        "sindrets/diffview.nvim",
        -- tag = "", -- None suitable
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-web-devicons").setup()
            map("n", "<leader>g", "<cmd>DiffviewOpen<CR>", { desc = "Open diff view" })
            map("n", "<leader>G", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })
        end,
    },

    {
        "vim-test/vim-test",
        keys = {
            { "<leader>tt", "<cmd>TestFile<cr>",    { desc = "Test Test" } },
            { "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test Nearest" } },
            { "<leader>ts", "<cmd>TestSuite<cr>",   { desc = "Test Suite" } },
            { "<leader>tl", "<cmd>TestLast<cr>",    { desc = "Test Last" } },
            { "<leader>tv", "<cmd>TestVisit<cr>",   { desc = "Test Visit" } },
        },
    },

})
