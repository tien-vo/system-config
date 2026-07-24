return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "mrjones2014/legendary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        }
    },
    config = function()
        local telescope = require("telescope")
        local legendary = require("legendary")

        -- Set up telescope
        telescope.setup({})
        telescope.load_extension("fzf")

        -- Set up legendary
        legendary.setup({
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
    end
}
