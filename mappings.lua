-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    [";"] = { ":" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
  },
    ["<D-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    ["<D-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    ["<D-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    ["<D-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },

    ["*"] = {
      "<cmd>keepjumps normal!*N<cr>",
      desc = "Search forward and highlight current first"
    },
    ["#"] = {
      "<cmd>keepjumps normal!#N<cr>",
      desc = "Search backward and highlight current first"
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
