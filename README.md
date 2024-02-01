# Notes

## Nvim-treesitter

It looks like apart from the nvim-treesitter plugin, there is a vim-treesitter that is native. I'm not sure if they operate independently though I think not.
There is some indication in the documentation of nvim-treesitter that it operates with vim-treesitter. However, vim-treesitter seemed to install
a few language parsers on its own along with queries for those languages. These couldn't be updated or installed with Tree Sitter.

running
```lua
echo nvim_get_runtime_file('parser', v:true)
```
and 
```lua
echo nvim_get_runtime_file('queries', v:true)
```

resulted in extra folders being listed apart from the ones that are in the plugins folder (`~/.local/share/nvim/lazy/nvim-treesitter/parser` 
and `~/.local/share/nvim/lazy/nvim-treesitter/queries`) 

These extra folders were native to the vim installation in `/opt/homebrew/Cellar/neovim/0.9.4/lib/nvim/parser`
and `//opt/homebrew/Cellar/neovim/0.9.4/share/nvim/runtime/queries`.

I renamed both those folders to `parser_old` and `queries_old` in those same directories and then reinstalled the language parsers that came natively with vim.
This fixed a bunch of check health issues that I saw. I might have to do this in the linux distribution separately as well.

The languages I reinstalled were
* C
* vim
* lua - error reported in checkhealth
* vimdoc - error reported in checkhealth
* query

After reinstalling using the plugin, all the errors were cleared.
