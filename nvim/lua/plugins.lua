return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                commentStyle = { italic = false },
                keywordStyle = { italic = false },
                statementStyle = { bold = false },
                overrides = function()
                    return {
                        Boolean = { bold = false },
                    }
                end,
            })
            vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                sync_root_with_cwd = true,
                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")
                    api.config.mappings.default_on_attach(bufnr)
                    vim.keymap.set("n", "v", api.node.open.vertical, { buffer = bufnr })
                end,
            })
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_c = {{"filename", path=1}},
                    lualine_x = {}
                }
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    initial_mode = "normal",
                    layout_strategy = "vertical",
                    sorting_strategy = "ascending",
                    layout_config = {
                        vertical = { prompt_position = "top", mirror = true },
                    },
                },
                pickers = {
                    buffers = {
                        mappings = {
                            n = { ["d"] = actions.delete_buffer },
                        },
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fi", builtin.live_grep)
            vim.keymap.set("n", "<leader>fb", builtin.buffers)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({})
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({ "c", "go", "lua" })
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev)
                    pcall(vim.treesitter.start, ev.buf)
                end,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            local telescope = require("telescope.builtin")

            -- Go
            vim.lsp.config("gopls", { settings = { gopls = { usePlaceholders = true } } })
            vim.lsp.enable("gopls")

            -- C
            vim.lsp.enable("clangd")

            vim.keymap.set("n", "gd", telescope.lsp_definitions, {
                desc = "Go to definition",
            })
            vim.keymap.set("n", "gr", telescope.lsp_references, {
                desc = "Go to references",
            })
            vim.keymap.set("n", "gi", telescope.lsp_implementations, {
                desc = "Go to implementation",
            })
        end,
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        config = function()
            require("blink.cmp").setup({
                keymap = {
                    preset = "enter",
                    ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
                },
                completion = {
                    list = { selection = { preselect = false, auto_insert = false } },
                    documentation = { auto_show = true, auto_show_delay_ms = 200 },
                    menu = { draw = { treesitter = { "lsp" } } },
                },
                signature = { enabled = true },
            })
        end,
    },
}
