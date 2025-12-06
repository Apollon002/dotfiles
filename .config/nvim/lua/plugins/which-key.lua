return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { registers = false },
	},
	keys = {
		{
			"<M-h>",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
