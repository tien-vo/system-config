local on_attach = function(client, buffer_number)
    -- Enable completion triggered by <C-x><C-o>
    vim.api.nvim_buf_set_option(buffer_number, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local options = { noremap=true, silent=true, buffer=buffer_number }
    vim.keymap.set(
        "n",
        "<Bslash>e",
        vim.diagnostic.open_float,
        options
    )
    vim.keymap.set(
        "n",
        "<S-f>",
        function()
            vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" } },
                apply = true,
            })
            vim.wait(100)
            vim.lsp.buf.format({ async=true })
        end,
        options)
end


return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pylsp"
            }
        })
        require("lspconfig").pylsp.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        -- Formatter
                        black = {
                            -- Plugin: python-lsp-black
                            enabled = true
                        },
                        -- Import sorting
                        pyls_isort = {
                            -- Plugin: pyls-isort
                            enabled = true,
                            profile = "black"
                        },
                        -- Linter
                        ruff = {
                            -- Plugin: python-lsp-ruff
                            enabled = true
                        },
                        -- Type checker
                        pylsp_mypy = {
                            -- Plugin: pylsp-mypy
                            enabled = true,
                            overrides = { "--python-executable", "python", true }
                        },
                    }
                }
            }
        })
    end,
}
