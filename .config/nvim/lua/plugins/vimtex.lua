return {
  "lervag/vimtex",
  lazy = false,
  --- settings need to go to the "init" function
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_mappings_enabled = 0 -- keymaps are defined in keymaps.lua
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-lualatex",
      },
      aux_dir = "build",
      --out_dir = "build",
      continuous = 1,
    }
  end,
}
