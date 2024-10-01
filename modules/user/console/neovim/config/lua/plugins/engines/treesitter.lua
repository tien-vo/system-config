return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-refactor",
    },
    init = function()
        require("nvim-treesitter.install").update({
            with_sync = true,
        })()
    end,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "cpp",
                "cmake",
                "bash",
                "latex",
                "lua",
                "python",
                "vim",
            },
            sync_install = false,
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = false },
            incremental_selection = { enable = true },
            refactor = {
                highlight_definitions = { enable = true },
            },
        })
    end
}
