return {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    config = function()
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_ui_contrast = "low"
        vim.g.gruvbox_material_diagnostic_text_highlight = 1
        vim.g.gruvbox_material_diagnostic_line_highlight = 1
        vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
        vim.cmd("set background=dark")
        vim.cmd("colorscheme gruvbox-material")
    end
}
