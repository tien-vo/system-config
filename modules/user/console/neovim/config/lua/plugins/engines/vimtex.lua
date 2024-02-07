-- NOTE: Using entr for force continuous mode. Need to install package separately

return {
    "lervag/vimtex",
    config = function()
        vim.g.tex_flavor = "latex"
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "generic"
        vim.g.vimtex_compiler_generic = {
            command = "ls *.tex | entr -nc tectonic --synctex --keep-logs /_"
        }
    end
}
