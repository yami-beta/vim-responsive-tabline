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

If you want to customize tabline's label, use `g:Responsive_tabline_custom_label_func` option.  
Note: If you use `g:Responsive_tabline_custom_label_func`, tabpage label is disabled.

```vim
function! s:show_buffers_to_tabline()
  let buffers = getbufinfo({ 'buflisted': 1 })
  return map(copy(buffers), '{ "active": v:val.bufnr == bufnr("%"), "name": v:val.bufnr." ".fnamemodify(v:val.name, ":t") }')
endfunction
let g:Responsive_tabline_custom_label_func = function('s:show_buffers_to_tabline')
```

## Known Bugs

- `E541` is shown in tabline if 20 and over tabpages are created.
  - Detail: `:h E541`

# LICENSE

MIT
