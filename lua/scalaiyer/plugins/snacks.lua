return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notify = { enabled = true },
    notifier = { enabled = true },
    dashboard = { enabeld = true },
    lazygit = {
      enabled = true,
      configure = true,
    },
  },
  keys = {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Open Lazygit" },
    { "<leader>llg", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
  }
}
