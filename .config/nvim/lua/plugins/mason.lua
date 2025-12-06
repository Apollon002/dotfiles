--- Mason: Package manager for LSP's, Linters, Debuggers & Formatters ---
return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	--- mason-tool-installer: for automated installation of Mason-Packages ---
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				--- Lua
				"lua-language-server", -- LSP
				"selene", -- linter
				"stylua", -- formatter
				--- Python
				"basedpyright", -- LSP
				"ruff", -- formatter & linter
				"debugpy", -- debugger
				--- C / C++
				"clangd", -- LSP
				"cpplint", -- linter
				"clang-format", -- formatter
				"codelldb", -- debugger  NOTE: (includes rust)
				-- Latex
				"texlab", -- LSP
				"latexindent", -- formatter
				"bibtex-tidy", -- formatter für bib-dateien
			},
			auto_update = false,
			run_on_start = true,
		},
	},

	--- mason-lspconfig: to automatically enable LSP's installed by Mason ---
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
