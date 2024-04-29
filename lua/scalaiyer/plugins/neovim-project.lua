return {
  "coffebar/neovim-project",
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = { { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
  config = function()
    local nvimproject = require("neovim-project")
    nvimproject.setup({
      projects = { -- define project roots
        "~/fun/*",
        "~/fun/kt/src/embedded/hubble",
        "~/.config/*",
        "~/.local/share/nvim",
        "~/.local/state/nvim",
        "~/.local/share/nvim/lazy/*",
        "~/fun/motive_aosp/src/vg5/services/DriverMonitor/tradefedhost/test_prep_tool",
      },
      dashboard_mode = true,
    })
    vim.keymap.set("n", "<leader>p", "<cmd>Telescope neovim-project discover<CR>", { desc = "Run NeoVim Project discover" })
    vim.keymap.set("n", "<leader>P", "<cmd>Telescop neovim-project history<CR>", { desc = "Run NeoVim Project history" })
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "SessionLoadPost",
      group = vim.api.nvim_create_augroup("ProjectLoader", { clear = true }),
      callback = function()
        local cwd = vim.fn.getcwd()
        local nvimRc = ".nvim.lua"
        local projectFileName = "project.lua"
        local projectFile = io.open(cwd .. "/" .. projectFileName)
        local nvimRcFile = io.open(cwd .. "/" .. nvimRc)
        if nvimRcFile then
          dofile(cwd .. "/" .. nvimRc)
        end
        if projectFile then
          package.path = cwd .. "/?.lua;" .. package.path
          local module = require("project")
          module.init()
        else
          return
        end
      end
    })
  end
}
