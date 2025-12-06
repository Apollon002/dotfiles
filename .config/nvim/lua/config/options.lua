vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

--- configure diagnostics ---
vim.diagnostic.config({
	virtual_text = true, -- Nachrichten rechts am Zeilenende
	signs = true, -- Icons / Buchstaben links in der SignColumn
	underline = true, -- Unterstreichungen im Code
	update_in_insert = false, -- nicht mitten im Tippen stören
	severity_sort = true, -- sortiert nach Fehlerstufe
})
