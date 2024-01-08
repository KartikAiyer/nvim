 return {
  "Civitasv/cmake-tools.nvim",
  dependencies = {"nvim-dap"},
  opts = {
    cmake_build_directory = "build/${variant:buildType}",
  },
}

