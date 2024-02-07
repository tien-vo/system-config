return {
    "rcarriga/nvim-notify",
    config = function()
        notify = require("notify")
        notify.setup({
            stages = "slide"
        })
        vim.notify = notify
    end,
}
