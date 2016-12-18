# vim-responsive-tabline

![vim-responsive-tabline demo](https://raw.githubusercontent.com/yami-beta/vim-responsive-tabline/master/images/demo.gif)

## Installation

Use plugin manager

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'yami-beta/vim-responsive-tabline'
```

## Option

If you want manually to enable vim-responsive-tabline, use `g:responsive_tabline_enable` option.

```vim
let g:responsive_tabline_enable = 0
set tabline=%!responsive_tabline#get_tabline()
```

# LICENSE

MIT
