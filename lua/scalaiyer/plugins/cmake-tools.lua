 return {
  "Civitasv/cmake-tools.nvim",
  dependencies = {"nvim-dap"},
  opts = {
    cmake_build_directory = "build/${variant:buildType}",
  },
   config = function()
     local cmake = require "cmake-tools"
     cmake.setup{}
     vim.keymap.set("n", "<leader>cg", "<cmd>CMakeGenerate<CR>", {desc = "Generate Cmake project"})
     vim.keymap.set("n", "<leader>ccp", "<cmd>CMakeSelectConfigurePreset<CR>", {desc = "Select Cmake configure preset"})
     vim.keymap.set("n", "<leader>cbp", "<cmd>CMakeSelectBuildPreset<CR>", {desc = "Select Cmake build preset"})
     vim.keymap.set("n", "<leader>clt", "<cmd>CMakeSelectLaunchTarget<CR>", {desc = "Select CMake Launch Target"})
     vim.keymap.set("n", "<leader>cr", "<cmd>CMakeRun<cr>", {desc = "CMake Run"})
   end
}

