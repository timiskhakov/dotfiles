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
}
