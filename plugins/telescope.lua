return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    opts.defaults.layout_config.width = 0.99
    opts.defaults.layout_config.height = 0.99
  end,
}
