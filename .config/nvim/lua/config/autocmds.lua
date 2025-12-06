-- Beim Eintritt in Insert-Mode: absolute Nummern
local acmd = vim.api.nvim_create_autocmd

acmd("InsertEnter", {
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = false
	end,
})

-- Beim Verlassen von Insert-Mode: wieder relative Nummern
acmd("InsertLeave", {
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = true
	end,
})

--- set up linters
acmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

--- open csv with csvview and without soft wrapping ---
acmd("FileType", {
	pattern = { "csv" }, -- ggf. erweitern: { "csv", "tsv" }
	callback = function()
		-- kein Softwrap
		vim.opt_local.wrap = false
		vim.opt_local.linebreak = false

		-- csvview mit gewünschten Optionen einschalten
		vim.cmd([[CsvViewToggle delimiter=, display_mode=border header_lnum=1]])
	end,
})
