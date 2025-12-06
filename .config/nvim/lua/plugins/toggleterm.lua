return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = true,
	opts = {
		open_mapping = "<M-t>",
		shell = "fish",
		direction = "float",
		float_opts = {
			border = "curved",
			winblend = 0, -- transparency
			width = 210,
			height = 40,
		},
	},
}
