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
            goto_next_start = { ["]m"] = "@function.outer", },
            goto_next_end =   { ["]M"] = "@function.outer", },
            goto_previous_start = { ["[m"] = "@function.outer", },
            goto_previous_end =   { ["[M"] = "@function.outer", },
          },
        },
      })
    end,
  },
}
