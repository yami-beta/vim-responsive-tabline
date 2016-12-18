if get(g:, 'loaded_responsive_tabline')
  finish
endif
let g:loaded_responsive_tabline = 1
let s:save_cpo = &cpo
set cpo&vim

let s:enable = get(g:, 'responsive_tabline_enable', 1)
if s:enable
  set tabline=%!responsive_tabline#get_tabline()
endif

let &cpo = s:save_cpo
unlet s:save_cpo
