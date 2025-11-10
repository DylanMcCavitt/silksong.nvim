<h4><div align="left">
    <a href="#installation">Installation</a>
    <span> | </span>
    <a href="#default-configuration">Configuration</a>
    <span> | </span>
    <a href="#customization">Customization</a>
    <span> &nbsp;&nbsp;&nbsp; &nbsp; </span>
</div></h4>

<sup>**_Disclaimer - I am not affiliated with \_Team Cherry_ or the _Hollow Knight_ series in anyway. This palette was just inspired by the colors/vibe from the games.\_**</sup>

**Dark, warm and light(1)** themes for a **Silksong** (_Hollow Knight: Silksong_) inspired colorscheme for neovim forked from [navarasu/onedark.nvim](https://github.com/navarasu/onedark.nvim)

_For Vim / Neovim < 0.5, prefer [joshdick/onedark.vim](https://github.com/navarasu/onedark.nvim)_

_For latest [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter) syntax highlight, upgraded to Neovim 0.8.0 or later built with tree-sitter 0.20.3+_

### Features

- 8 theme styles, 5 dark/warm and one light variant.
- Supporting multiple plugins with hand picked proper colors
- Customize `Colors`, `Highlights` and `Code style` of the theme as you like (Refer [Customization](#customization))
- Toggle the theme style without exiting Neovim using `toggle_style_key` (Refer [Config](#default-configuration))

## Themes

<p float="left">
<img width="412" alt="Silksong - marrow" src="">
<img width="412" alt="silksong - slab" src="">
</div></p>
<p float="left">
<img width="412" alt="silksong - greymoor" src="">
</div></p>
<p float="left">
<img width="412" alt="silksong - abyss" src="">
<img width="412" alt="silksong - memorium" src="">
<<img width="412" alt="silksong - cradle" src="">
<img width="412" alt="silksong - weavenest" src="">
/div></p>

## Installation

Install via your favorite package manager

```lua
-- Using Lazy
{
  "dylanmccavitt/silksong.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('silksong').setup {
      style = 'marrow'
    }
    -- Enable theme
    require('silksong').load()
  end
}
```

```vim
" Using Vim-Plug
Plug 'dylanmccavitt/silksong.nvim'
```

```lua
-- Using Packer
use 'dylanmccavitt/silksong.nvim'
```

## Configuration

### Enable theme

```lua
-- Lua
require('silksong').load()
```

```vim
" Vim
colorscheme silksong
```

### Change default style

```lua
-- Lua
require('silksong').setup {
    style = 'marrow'
}
require('silksong').load()
```

```vim
" Vim
let g:silksong_config = {
    \ 'style': 'marrow',
\}
colorscheme onedark
```

> **Options:** marrow(dark/warm), slab(darker), greymoor(cool), abyss(deep), memorium(warm), cradle(warmer), weavenest(light)

## Default Configuration

```lua
-- Lua
require('silksong').setup  {
    -- Main options --
    style = 'marrow', -- Default theme style. Choose between 'marrow(dark/warm), slab(darker), greymoor(cool), abyss(deep), memorium(warm), cradle(warmer), weavenest(light)
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'marrow', 'slab', 'greymoor', 'abyss', 'memorium', 'cradle', 'weavenest'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
```

### Vimscript configuration

Silksong can be configured also with Vimscript, using the global dictionary `g:silksong_config`.
**NOTE**: when setting boolean values use `v:true` and `v:false` instead of 0 and 1

Example:

```vim
let g:silksong_config = {
  \ 'style': 'marrow',
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:false,
  \ },
\ }
colorscheme silksong
```

## Customization

Example custom colors and Highlights config

```lua
require('silksong').setup {
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
  },
  highlights = {
    ["@keyword"] = { fg = "$green" },
    ["@property"] = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    ["@lsp.function"] =  {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    ["@lsp.type.method"] = { link = "@function" },
  -- To add language specific config
    ["@lsp.type.variable.javascript"] = { fg = "#ffffff" },
  }
}
```

Note that TreeSitter keywords have been changed after neovim version 0.8 and onwards.
TS prefix is trimmed and lowercase words should be used separated with '.'

The old way before neovim 0.8 looks like this.
For all keywords see [this](https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/highlights.lua#L133-L257) file from line 133 to 257

```lua
require('silksong').setup {
  colors = {
    bright_orange = "#ff8800",    -- define a new color
    green = '#00ffaa',            -- redefine an existing color
  },
  highlights = {
    TSKeyword = {fg = '$green'},
    TSString = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
    TSFunction = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    TSFuncBuiltin = {fg = '#0059ff'}
  }
}
```

## Plugins Configuration

### Enable lualine

To Enable the `onedark` theme for `Lualine`, specify theme as `onedark`:

```lua
require('lualine').setup {
  options = {
    theme = 'onedark'
    -- ... your lualine config
  }
}
```

## Plugins Supported

- [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [LSPDiagnostics](https://neovim.io/doc/user/lsp.html)
- [NvimTree](https://github.com/kyazdani42/nvim-tree.lua)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [WhichKey](https://github.com/folke/which-key.nvim)
- [Dashboard](https://github.com/glepnir/dashboard-nvim)
- [Lualine](https://github.com/hoob3rt/lualine.nvim)
- [GitGutter](https://github.com/airblade/vim-gitgutter)
- [GitSigns](https://github.com/lewis6991/gitsigns.nvim)
- [VimFugitive](https://github.com/tpope/vim-fugitive)
- [DiffView](https://github.com/sindrets/diffview.nvim)
- [Hop](https://github.com/phaazon/hop.nvim)
- [Mini](https://github.com/echasnovski/mini.nvim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Neotest](https://github.com/nvim-neotest/neotest)
- [Barbecue](https://github.com/utilyre/barbecue.nvim)
- [IndentBlankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- Many more

## Reference

- [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim)
- [one-dark-theme](https://github.com/andresmichel/one-dark-theme)
- [bamboo.nvim](https://github.com/ribru17/bamboo.nvim?tab=readme-ov-file)

## Contributing

Pull requests are welcome 🎉👍.

## License

[MIT](https://choosealicense.com/licenses/mit/)
