return {
	"nvim-mini/mini.nvim",
	version = "*",
	opts = {},

	config = function()
		require("mini.surround").setup()
	end,
}
