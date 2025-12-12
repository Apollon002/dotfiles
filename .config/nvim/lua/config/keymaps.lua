-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<leader>lc", "<Plug>(vimtex-compile)", { desc = "VimTeX: Compile", silent = true })
map("n", "<leader>lk", "<Plug>(vimtex-stop)", { desc = "VimTeX: Stop compile", silent = true })
map("n", "<leader>lv", "<Plug>(vimtex-view)", { desc = "VimTeX: View PDF", silent = true })
map("n", "<leader>lt", "<Plug>(vimtex-toc-open)", { desc = "VimTeX: Open TOC", silent = true })
map("n", "<leader>ll", "<Plug>(vimtex-log)", { desc = "VimTeX: Show log", silent = true })
map("n", "<leader>li", "<Plug>(vimtex-info)", { desc = "VimTeX: Project info", silent = true })
map("n", "<leader>le", "<Plug>(vimtex-errors)", { desc = "VimTeX: Errors (quickfix)", silent = true })

map("n", "<leader>ee", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
map("n", "<leader>ed", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })

-- prior buffer
map("n", "<C-Left>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Switch to next buffer" })

-- next buffer
map("n", "<C-Right>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Switch to prior buffer" })

-- close current buffer
map("n", "<C-q>", "<Cmd>bdelete<CR>", { desc = "close current buffer" })
