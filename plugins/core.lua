return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      local button = require("astronvim.utils").alpha_button
      opts.section.buttons.val = {
        -- button("LDR n", "  New File  "),
        button("LDR f f", "  Find File  "),
        button("LDR f o", "  Recents  "),
        -- button("LDR f w", "  Find Word  "),
        button("LDR f '", "  Bookmarks  "),
        button("LDR S f", "  Find Session  "),
        button("LDR S l", "  Last Session  "),
      }
      return opts
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.render = "compact"
      opts.timeout = 3000 -- 0 to disable notification
      opts.stages = "static"
    end,
  },
  -- user optional plugins list below
  {
    "ukyouz/onedark.vim",
    config = function()
      vim.g.onedark_style = "darker"
    end,
  },
  {
    "wellle/context.vim",
    event = "BufEnter",
    config = function()
      local group = vim.api.nvim_create_augroup("context_au", { clear = true, })
      vim.api.nvim_create_autocmd({"BufEnter"}, {
        desc = "Enable context.vim for current buffer",
        group = group,
        command = "ContextEnable",
      })
    end,
  },
  {
    "ludovicchabant/vim-gutentags",
    enabled = false,
    event = "VimEnter",
    init = function()
      local user_dir = vim.api.nvim_eval("expand('~/.LfCache/gtags')")
      -- vim.o.cscopetag = true
      -- vim.o.cscopeprg = "gtags-cscope"
      vim.g.gutentags_modules = {"ctags", "gtags_cscope"}
      vim.g.gutentags_cache_dir = user_dir
    end,
  },
  ---- better text object action ----
  { "tpope/vim-surround", event = "BufEnter", },  -- add surround movement
  { "tpope/vim-repeat", event = "BufEnter", },  -- better . repeat action
  { "tpope/vim-unimpaired", event = "BufEnter", }, -- add common `[`, `]` movement
  { "wellle/targets.vim", event = "BufEnter", }, -- add more textobject
  { "mg979/vim-visual-multi",
    event = "BufEnter",
    config = function()
      vim.g.VM_theme = "codedark"
    end,
  },
  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
}
