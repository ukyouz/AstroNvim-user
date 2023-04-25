return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    opts = {
      disable = function(lang, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 5000
      end,
      -- ensure_installed = { "lua" },
      highlight = {
        additional_vim_regex_highlighting = true,
      },
      refactor = {
        highlight_definitions = { enable = false },
        highlight_current_scope = { enable = false },
        smart_rename = {
          enable = true,
          keymaps = { smart_rename = "grr", },
        },
        navigation = {
          enable = true,
          keymaps = {
            goto_definition = "<a-)>", --- alt-shift-0
            -- goto_next_usage = "<a-*>", --- alt-shift-8
            -- goto_previous_usage = "<a-#>", --- alt-shlft-3
          }
        }
      },
    },
  },
  {
    "nvim-treesitter/playground",
    event = "BufReadPost",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = true,
            swap_next =     { ["<leader>a"] = "@parameter.inner", },
            swap_previous = { ["<leader>A"] = "@parameter.inner", },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = { ["]f"] = "@function.outer", ["]j"] = "@loop.outer" },
            goto_next_end = { ["]F"] = "@function.outer", },
            goto_previous_start = { ["[f"] = "@function.outer", ["[j"] = "@loop.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", },
          },
        },
      })

      vim.api.nvim_set_keymap(
            "n", "[t", "",
            {
                desc = "Go to current function name",
                noremap = false,
                callback = function()
                    vim.api.nvim_exec("normal [f", false)
                    vim.fn.search('(', 'c')
                    vim.api.nvim_exec("normal B", false)
                end,
            }
        )
    end,
  },
}
