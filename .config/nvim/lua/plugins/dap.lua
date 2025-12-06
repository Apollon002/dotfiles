--- Debugger ---
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		--- Activate Python (debugpy) ---
		local mason_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(mason_python)
	end,
}
