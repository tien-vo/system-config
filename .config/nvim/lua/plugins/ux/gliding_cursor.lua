return {
    "yuttie/comfortable-motion.vim",
    config = function()
        vim.g.comfortable_motion_scroll_down_key = "j"
        vim.g.comfortable_motion_scroll_up_key = "k"
        vim.g.comfortable_motion_friction = 2.0
        vim.g.comfortable_motion_air_drag = 4.0
    end
}
