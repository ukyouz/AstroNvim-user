return {
  {
    "Yggdroot/LeaderF",
    event = "VimEnter",
    init = function()
        local utils = require "astronvim.utils"
        vim.g.Lf_Gtagslabel = "native-pygments"
        vim.g.Lf_GtagsGutentags = true
        vim.g.Lf_GtagsAutoGenerate = false
        vim.g.Lf_GtagsAutoUpdate = false

        vim.g.Lf_ShortcutF = "<leader>ff"  -- to avoid <leader>f open LeaderfFile picker
        vim.g.Lf_ShortcutB = "<leader>fb"  -- to avoid <leader>b open LeaderBuffer picker

        vim.g.Lf_WindowPosition = 'popup'
        vim.g.Lf_WindowHeight = 0.4
        vim.g.Lf_PopupHeight = 0.4
        vim.g.Lf_PopupWidth = 0.8
        vim.g.Lf_PopupPosition = {1, 0}
        vim.g.Lf_PopupPreviewPosition = 'bottom'
        vim.g.Lf_DefaultMode = 'NameOnly'
        vim.g.Lf_PreviewInPopup = 1
        vim.g.Lf_ShowDevIcons = 1
        vim.g.Lf_JumpToExistingWindow = 0
        vim.g.Lf_StlSeparator = { left = "", right = "" }
        vim.g.Lf_NormalMap = {
            _ =     {{"<C-j>", "j"},
                      {"<C-k>", "k"}
                     },
            File=   {{"<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>'}},
            Buffer= {{"<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>'}},
            Mru=    {{"<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>'}},
            Tag=    {{"<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>'}},
            Gtags=  {{"<ESC>", ':exec g:Lf_py "gtagsExplManager.quit()"<CR>'}},
            BufTag= {{"<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<CR>'}},
            Function= {{"<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>'}},
            Rg=     {{"<ESC>", ':exec g:Lf_py "rgExplManager.quit()"<CR>'}},
            Line=   {{"<ESC>", ':exec g:Lf_py "lineExplManager.quit()"<CR>'}},
            History={{"<ESC>", ':exec g:Lf_py "historyExplManager.quit()"<CR>'}},
            Help=   {{"<ESC>", ':exec g:Lf_py "helpExplManager.quit()"<CR>'}},
            Self=   {{"<ESC>", ':exec g:Lf_py "selfExplManager.quit()"<CR>'}},
            Colorscheme= {{"<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>'}},
        }
        vim.g.Lf_PreviewResult = {
            File = 0,
            Buffer = 0,
            Mru = 1,
            Tag = 0,
            BufTag = 1,
            Function = 0,
            Line = 1,
            Colorscheme = 1,
            Rg = 0,
            Gtags = 1,
        }

        vim.g.Lf_CtagsFuncOpts = {
            python = "--langmap=Python:.py.pyw",
            c = "--excmd=number --fields=+nS"
        }
    end,
    config = function()
        -- rebind keymap here to replace telescope keymaps
        vim.api.nvim_set_keymap(
            "n", "<leader>fd", "",
            {
                desc = "Jump to definition (Gtags)",
                noremap = false,
                callback = function()
                    local cword = vim.fn.expand('<cword>')
                    vim.api.nvim_exec(string.format("Leaderf! gtags -d %s --auto-jump", cword), true)
                end,
            }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>ff", "<cmd>:LeaderfFile<cr>",
            { desc = "Find files", noremap = false, }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>ft", "<cmd>:LeaderfTag<cr>",
            { desc = "Find tags (Ctags)", noremap = false, }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>fg", "<cmd>:Leaderf gtags<cr>",
            { desc = "Find tags (Gtags)", noremap = false, }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>fR", "",
            {
                desc = "Find references",
                noremap = false,
                callback = function()
                    local cword = vim.fn.expand('<cword>')
                    vim.api.nvim_exec(string.format("Leaderf! gtags -r %s --auto-preview --auto-jump", cword), true)
                end,
            }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>fG", "<cmd>:Leaderf! gtags --recall <cr>",
            { desc = "Resume previous Leaderf gtags window", noremap = false, }
        )

        vim.api.nvim_set_keymap(
            "n", "<leader>fr", "<cmd>:Leaderf! rg<cr>",
            {
                desc = "Find words (Leaderf rg)",
                noremap = false,
            }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>fk", "",
            {
                desc = "Find current word (Leaderf rg)",
                noremap = false,
                callback = function()
                    local cword = vim.fn.expand('<cword>')
                    vim.api.nvim_exec(string.format("Leaderf! rg -s -w -F %s ", cword), true)
                end,
            }
        )
        vim.api.nvim_set_keymap(
            "n", "<leader>fK", "<cmd>:Leaderf! rg --recall <cr>",
            { desc = "Resume previous Leaderf rg window", noremap = false, }
        )
    end,
  },
}