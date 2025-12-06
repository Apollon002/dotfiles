local map = vim.keymap.set
--- bind movement keys so you can navigate through softwrapped lines ---
map({ "n", "v" }, "j", "gj", { silent = true })
map({ "n", "v" }, "k", "gk", { silent = true })
map({ "n", "v" }, "<Down>", "gj", { silent = true })
map({ "n", "v" }, "<Up>", "gk", { silent = true })

--- Themery: Theme picker ---
map("n", "<leader><CR>", "<cmd>Themery<cr>", { desc = "Open theme picker" })

--- fzf-lua ---
map("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Fuzzy-find files in current working directory" })
map("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "Fuzzy-find content inside files in current working directory" })

--- nvim_yazi ---
map("n", "<leader>ee", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
map("n", "<leader>ed", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })

--- conform-formatting ---
map({ "n", "v" }, "<leader>f", function()
	require("conform").format({ lsp_format = "fallback", async = true })
end, { desc = "Format buffer or selection" })

--- buffer hopping ---

-- prior buffer
map("n", "<C-Left>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Switch to next buffer" })

-- next buffer
map("n", "<C-Right>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Switch to prior buffer" })

-- close current buffer
map("n", "<C-q>", "<Cmd>bdelete<CR>", { desc = "close current buffer" })

--- code actions ---
map("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "open code actions" })

--- codesnap ---
map("v", "<leader>cc", ":'<,'>CodeSnap<CR>", { desc = "Save selected code snapshot into clipboard", silent = true })
map("v", "<leader>cs", ":'<,'>CodeSnapSave<CR>", { desc = "Save selected code snapshot to file", silent = true })

--- Doc String gen ---
map("n", "<leader>dg", function()
	require("neogen").generate()
end, { desc = "Generate doc string for a function", silent = true })

--- csv-viewer: csvview ---
map(
	"n",
	"<leader>csv",
	"<Cmd>CsvViewEnable display_mode=border<CR>",
	{ desc = "Format csv-files to a tabular view", silent = true }
)

--- Leap ---
map({ "n", "x", "o" }, "s", "<Plug>(leap)")
map("n", "S", "<Plug>(leap-from-window)")

--- Markdown Preview ---
map("n", "<leader>md", "<Cmd>MarkdownPreview<CR>", { desc = "Preview Markdown File" })

--- Trouble Keymaps ---
map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map(
	"n",
	"<leader>tl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
map("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
map("n", "<leader>to", "<cmd>Trouble todo toggle<cr>", { desc = "Todo List (todo-comments plugin)" })

--- DAP-Debugger ---
local dap = require("dap")
map("n", "<Leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "toggle breakpoint for debugging session" })
map("n", "<F5>", function()
	dap.continue()
end, { desc = "continue to next program step for debugging session" })

--- Vimtex ---
map("n", "<leader>lc", "<Plug>(vimtex-compile)", { desc = "VimTeX: Compile", silent = true })
map("n", "<leader>lk", "<Plug>(vimtex-stop)", { desc = "VimTeX: Stop compile", silent = true })
map("n", "<leader>lv", "<Plug>(vimtex-view)", { desc = "VimTeX: View PDF", silent = true })
map("n", "<leader>lt", "<Plug>(vimtex-toc-open)", { desc = "VimTeX: Open TOC", silent = true })
map("n", "<leader>ll", "<Plug>(vimtex-log)", { desc = "VimTeX: Show log", silent = true })
map("n", "<leader>li", "<Plug>(vimtex-info)", { desc = "VimTeX: Project info", silent = true })
map("n", "<leader>le", "<Plug>(vimtex-errors)", { desc = "VimTeX: Errors (quickfix)", silent = true })

-- NOTE: plugin internal keymaps: ---

-- Add surrounding with sa (in visual mode or on motion).
-- Delete surrounding with sd.
-- Replace surrounding with sr.
-- Find surrounding with sf or sF (move cursor right or left).
-- Highlight surrounding with sh.
