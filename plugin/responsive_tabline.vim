if get(g:, 'loaded_responsive_tabline')
  finish
endif
let g:loaded_responsive_tabline = 1
let s:save_cpo = &cpo
set cpo&vim

set tabline=%!responsive_tabline#get_tabline()

let &cpo = s:save_cpo
unlet s:save_cpo
