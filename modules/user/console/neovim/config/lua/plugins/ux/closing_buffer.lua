return {
    "moll/vim-bbye",
    lazy = false,
    keys = {
        { "<S-h>", ":BufferPrevious<CR>", desc = "Move to previous buffer" },
        { "<S-l>", ":BufferNext<CR>", desc = "Move to next buffer" },
        { "<C-c>", ":Bwipeout<CR>", desc = "Close buffer" },
    }
}
