return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	opts = {},

	config = function()
		require("lint").linters_by_ft = {
			lua = { "selene" },
			-- python = { "ruff" },  already loaded by lsp
			c = { "cpplint" },
			cpp = { "cpplint" },
		}
	end,
}
