return {
    "rcarriga/nvim-notify",
    config = function()
        vim.opt.termguicolors = true

        notify = require("notify")
        notify.setup({
            stages = "slide"
        })
        vim.notify = notify
    end,
}
