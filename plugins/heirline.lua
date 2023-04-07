return {
  "rebelot/heirline.nvim",
  event = "BufEnter",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    local utils = require ("heirline.utils")
    local conditions = require ("heirline.conditions")
    opts.tabline = nil
    opts.winbar = { -- winbar
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false,
    --   {
    --     condition = function() return not status.condition.is_active() end,
    --     status.component.separated_path(),
    --     status.component.file_info {
    --       file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
    --       file_modified = false,
    --       file_read_only = false,
    --       hl = status.hl.get_attributes("winbarnc", true),
    --       surround = false,
    --       update = "BufEnter",
    --     },
    --   },
      status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
      status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
  }

  local mode_colors = {
    n = utils.get_highlight("Directory").fg,
    i = utils.get_highlight("String").fg,
    v = utils.get_highlight("Function").fg,
    V = utils.get_highlight("Function").fg,
    R = utils.get_highlight("DiagnosticError").fg,
    t = utils.get_highlight("Directory").fg,
    c = utils.get_highlight("Number").fg,
  }
  local FileNameBlock = {
      -- let's first set up some attributes needed by this component and it's children
      init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
      end,
      hl = function(self)
          local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
          return { fg = mode_colors[mode], }
      end,
  }
  local FileName = {
      provider = function(self)
          local filename = vim.fn.expand("%:p:.")
          if filename == "" then return "[No Name]" end
          if not conditions.width_percent_below(#filename, 0.25) then
              filename = vim.fn.pathshorten(filename)
          end
          return filename
      end,
  }
  local FileFlags = {
      {
          condition = function()
              return vim.bo.modified
          end,
          provider = "[+]",
      },
      {
          condition = function()
              return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = "",
      },
  }
  FileNameBlock = utils.insert(FileNameBlock,
      FileName,
      FileFlags,
      -- this means that the statusline is cut here when there's not enough space
      { provider = '%<  '} 
  )
  local Ruler = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      { provider = "%7(%l:%c%) " },
      {
        static = {
            sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
            -- Another variant, because the more choice the better.
            -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
        },
        provider = function(self)
            local curr_line = vim.api.nvim_win_get_cursor(0)[1]
            local lines = vim.api.nvim_buf_line_count(0)
            local i = math.floor((curr_line - 1) / lines * #self.sbar)
            return self.sbar[#self.sbar - i]
            -- return string.format("%.0f%%", 100 * (curr_line - 1) / lines)
        end,
      },
  }

  opts.statusline = { -- statusline
    hl = { fg = "fg", bg = "bg" },
    status.component.mode(),
    FileNameBlock,
    -- status.component.git_branch(),
    status.component.fill(),
    status.component.cmd_info(),
    status.component.file_info { filetype = {}, filename = false, file_modified = false },
    -- status.component.git_diff(),
    status.component.diagnostics(),
    status.component.lsp(),
    Ruler,
    -- status.component.treesitter(),
    -- status.component.nav(),
    -- status.component.mode { surround = { separator = "right" } },
  }
  end,
}
