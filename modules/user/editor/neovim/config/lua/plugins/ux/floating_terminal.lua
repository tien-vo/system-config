return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            open_mapping = "<C-t>",
            direction = "horizontal",
            shade_terminals = false
        })
    end
}
