return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        map("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
        map("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)
        map("n", "<C-c>", "<Cmd>BufferClose<CR>", opts)

        require("barbar").setup({
            animation = true,
            auto_hide = false,
            tabpages = true,
            clickable = false,
            hide = {current = false, inactive = false, visible = false},
            icon_custom_colors = false,
            insert_at_end = true,
            insert_at_start = false,
            semantic_letters = true,
            sidebar_filetypes = {
                NvimTree = { text = "File Tree", align = "center" },
            },
            letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
            no_name_title = nil,
            icons = {
                filetype = { enabled = true },
                active = { separator = { left = "▎" } },
                inactive = { separator = { left = "▎" } },
                pinned = { button = "車" },
                modified = { button = "●" },
                button = "",
            },
        })
    end,
}
