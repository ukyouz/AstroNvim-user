return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require "telescope.actions"
    local action_layout = require "telescope.actions.layout"
    opts.defaults.layout_strategy = "center"
    opts.defaults.layout_config.center = {
      prompt_position = "top",
      height = 0.4,
      width = 0.99,
      anchor = "N",
      mirror = true,
      preview_cutoff = 0, -- always show preview event at small visible region
    }
    opts.defaults.mappings.i = {
      ["<Down>"] = actions.cycle_history_next,
      ["<Up>"] = actions.cycle_history_prev,
      ["<C-p>"] = action_layout.toggle_preview,
      ["<C-d>"] = actions.delete_buffer,
      ["<C-u>"] = false,
      ["<D-d>"] = actions.preview_scrolling_down,
      ["<D-u>"] = actions.preview_scrolling_up,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<Esc>"] = function(_bufnr)
        actions.close(_bufnr)
        -- return to normal mode, ugly but it works
        local key = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
        vim.api.nvim_feedkeys(key, "n", false)
      end,
    }
    opts.defaults.mappings.n = {
      ["p"] = action_layout.toggle_preview,
      ["d"] = actions.delete_buffer,
    }
  end,
}
