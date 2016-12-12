if get(g:, 'loaded_autoload_responsive_tabline')
  finish
endif
let g:loaded_autoload_responsive_tabline = 1
let s:save_cpo = &cpo
set cpo&vim

function! s:get_tabpage_label(tabpagenr, tab_width)
  let tabpage_buflist = tabpagebuflist(a:tabpagenr)
  let active_bufnr = tabpage_buflist[tabpagewinnr(a:tabpagenr) - 1]

  " highlight current tabpage
  let hi = a:tabpagenr is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  let filename = bufname(active_bufnr)
  if filename ==# ''
    let filename = '[No Name]'
  else
    let filename = fnamemodify(filename, ':t')
  endif
  let filename = a:tabpagenr.' '.filename

  let tabpage_label_min_width = 8
  if a:tab_width < tabpage_label_min_width
    let filename = a:tabpagenr
  endif

  " `2` means insert a space to before and after label
  " e.g. `let label = ' '.filename.' '`
  let label_margin = 2
  let filename_length = strwidth(filename) + label_margin
  if filename_length > a:tab_width
    " Truncate filename
    let ellipsis = '...'
    let filename = filename[0:(a:tab_width - strwidth(ellipsis) - label_margin - 1)].ellipsis
  else
    " Append spacer
    let filename = filename . repeat(' ', a:tab_width - filename_length)
  endif
  let label = ' ' . filename . ' '

  return '%' . a:tabpagenr . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! responsive_tabline#get_tabline() abort
  let width = &columns
  let tabpage_count = tabpagenr('$')
  let tab_width = float2nr(width / tabpage_count)
  let labels = map(range(1, tabpagenr('$')), 's:get_tabpage_label(v:val,'. tab_width . ')')
  let tabpages = join(labels, '') . '%#TabLineFill#%T'

  return tabpages . '%='
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
