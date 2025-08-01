return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<S-h>", ":BufferPrevious<CR>", desc = "Move to previous buffer" },
        { "<S-l>", ":BufferNext<CR>", desc = "Move to next buffer" },
        { "<C-c>", ":BufferClose<CR>", desc = "Close buffer" },
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        animation = true,
        tabpages = true,
        clickable = false,
        auto_hide = false,
        icon_custom_colors = false,
        insert_at_end = true,
        insert_at_start = false,
        hide = {current = false, inactive = false, visible = false},
        semantic_letters = true,
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
        sidebar_filetypes = {
            NvimTree = true
        }
    }
}
