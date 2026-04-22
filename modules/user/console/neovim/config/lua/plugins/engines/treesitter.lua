return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  main = "nvim-treesitter",
  init = function()
    -- Ensure installation
    local ensure_installed = {
      "c",
      "cpp",
      "cmake",
      "bash",
      "latex",
      "lua",
      "python",
      "vim",
    }
    local already_installed = require("nvim-treesitter.config").get_installed()
    local to_install = vim.iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end)
      :totable()
    require("nvim-treesitter").install(to_install)

    -- Syntax highlighting and indenting
    vim.api.nvim_create_autocmd("FileType", { 
      callback = function() 
        pcall(vim.treesitter.start) 
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
      end, 
    })
  end,
}
