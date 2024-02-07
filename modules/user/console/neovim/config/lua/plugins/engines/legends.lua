return {
    "mrjones2014/legendary.nvim",
    config = function()
        require("legendary").setup({
            extensions = {
                lazy_nvim = true,
                nvim_tree = true,
                smart_splits = {
                    direction = { "h", "j", "k", "l" },
                    mods = {
                        move = "<C>",
                        resize = { mod = "<A>", prefix = "<leader>" },
                        swap = false
                    }
                }
            }
        })
    end,
}
