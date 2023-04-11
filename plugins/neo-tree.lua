return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        opts.filesystem.hide_hidden = false
        opts.filesystem.follow_current_file = true
        opts.filesystem.group_empty_dirs = true
        opts.filesystem.hijack_netrw_behavior = "open_default"
    end
}
