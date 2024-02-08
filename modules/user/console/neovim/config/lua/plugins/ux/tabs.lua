return {
    "romgrk/barbar.nvim",
    keys = {
        { "<S-h>", ":BufferPrevious<CR>", desc = "Move to previous buffer" },
        { "<S-l>", ":BufferNext<CR>", desc = "Move to next buffer" },
        { "<C-c>", ":BufferClose<CR>", desc = "Close buffer" },
    },
    config = function()
        local nvim_tree_events = require("nvim-tree.events")
        local nvim_tree_view = require("nvim-tree.view")
        local bufferline_api = require("bufferline.api")

        require("barbar").setup({
            icons = {
                filetype = { enabled = true },
                active = { separator = { left = "▎" } },
                inactive = { separator = { left = "▎" } },
            },
            animation = true,
            auto_hide = true,
            tabpages = true,
            clickable = false,
            hide = {current = false, inactive = false, visible = false},
            icon_custom_colors = false,
            insert_at_end = true,
            insert_at_start = false,
            maximum_padding = 1,
            minimum_padding = 1,
            maximum_length = 30,
            semantic_letters = true,
            letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
            no_name_title = nil,
        })

        local function get_tree_size() return nvim_tree_view.View.width end
        nvim_tree_events.subscribe("TreeOpen", function() bufferline_api.set_offset(get_tree_size()) end)
        nvim_tree_events.subscribe("Resize", function() bufferline_api.set_offset(get_tree_size()) end)
        nvim_tree_events.subscribe("TreeClose", function() bufferline_api.set_offset(0) end)
    end,
}
