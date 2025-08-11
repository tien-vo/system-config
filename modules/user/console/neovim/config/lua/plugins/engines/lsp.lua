local on_attach = function(client, buffer_number)
    -- Enable completion triggered by <C-x><C-o>
    vim.api.nvim_buf_set_option(buffer_number, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local options = { noremap=true, silent=false, buffer=buffer_number }
    vim.keymap.set(
        "n",
        "<Bslash>e",
        vim.diagnostic.open_float,
        options
    )
    vim.keymap.set(
        "n",
        "<S-t>",
        vim.lsp.buf.code_action,
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
            vim.lsp.buf.code_action({
                context = { only = { "source.fixAll" } },
                apply = true,
            })
            vim.wait(100)
            vim.lsp.buf.format({ async=true })
        end,
        options
    )
end


return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", version = "^1.0.0" },
        { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
        "hinell/lsp-timeout.nvim",
    },
    init = function(_)
        require("mason").setup()
        local pylsp = require("mason-registry").get_package("python-lsp-server")
        pylsp:on("install:success", function()
            local function mason_package_path(package)
                local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
                return path
            end

            local path = mason_package_path("python-lsp-server")
            local command = path .. "/venv/bin/pip"
            local args = {
                "install",
                "-U",
                "python-lsp-black",
                "python-lsp-isort",
                "python-lsp-ruff",
                "pylsp-mypy",
                "ruff",
            }

            require("plenary.job")
                :new({
                    command = command,
                    args = args,
                    cwd = path,
                })
                :start()
        end)
    end,
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        vim.lsp.set_log_level("debug")

        require("vim.lsp.log").set_format_func(vim.inspect)
        require("mason").setup()
        require("mason-lspconfig").setup({ ensure_installed = { "pylsp" } })
        require("lspconfig").pylsp.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        -- Formatter
                        black = {
                            -- Plugin: python-lsp-black
                            enabled = true,
                            line_length = 79
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
                            enabled = true,
                            formatEnabled = false,
                            lineLength = 79
                        },
                        -- Type checker
                        pylsp_mypy = {
                            -- Plugin: pylsp-mypy
                            enabled = true,
                            overrides = { "--python-executable", "python", true }
                        },
                        -- Disable linters
                        flake8 = { enabled = false },
                        pyflakes = { enabled = false },
                        pylint = { enabled = false },
                        pycodestyle = { enabled = false },
                        mccabe = { enabled = false },
                    }
                }
            }
        })
    end,
}
