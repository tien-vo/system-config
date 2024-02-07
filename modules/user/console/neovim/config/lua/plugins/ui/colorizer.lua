return {
    "norcalli/nvim-colorizer.lua",
    name = "colorizer",
    config = function()
        vim.opt.termguicolors = true
        require("colorizer").setup({})
    end
}
