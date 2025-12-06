return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			git = { enabled = true },
			bigfile = { enabled = true },
			indent = { enabled = true },
			image = { enabled = true },
		},
	},
}
