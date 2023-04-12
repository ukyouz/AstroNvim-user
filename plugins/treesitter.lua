return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- ensure_installed = { "lua" },
      highlight = {
        additional_vim_regex_highlighting = true,
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
