return  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<C-n>", ":NvimTreeToggle<CR>", desc = "Toggle file tree" }
    },
    config = function()
        -- Disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- Custom on-attach
        local function custom_on_attach(bufnr)
            local api = require("nvim-tree.api")
            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true,
                }
            end

            api.config.mappings.default_on_attach(bufnr)
            api.events.subscribe(api.events.Event.TreeOpen, function()
                vim.api.nvim_set_hl(0, "NvimTreeNormal", {link = "Normal"})
                vim.api.nvim_set_hl(0, "NvimTreeNormalNC", {link = "NormalNC"})
                vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", {link = "EndOfBuffer"})
                vim.api.nvim_set_hl(0, "NvimTreeNormal", {link = "SignColumn"})

                vim.wo.fillchars = "eob: "
            end)
        end

        -- Setup
        require("nvim-tree").setup({
            disable_netrw = true,
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                adaptive_size = true,
            },
            renderer = {
                 group_empty = true,
                 highlight_git = true,
                 highlight_opened_files = "all",
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
            },
            on_attach = custom_on_attach,
        })
    end
}
