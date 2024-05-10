-- Remap space as leader key.
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = "<Space>"

-- Enable loading optimizer to improve startup time
vim.loader.enable()

require("config.lazy")
require("config.options")
require("config.autocmds")
