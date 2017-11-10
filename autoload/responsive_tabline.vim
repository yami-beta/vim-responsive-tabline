if get(g:, 'loaded_autoload_responsive_tabline')
  finish
endif
let g:loaded_autoload_responsive_tabline = 1
let s:save_cpo = &cpo
set cpo&vim

function! s:resize_label(tabpagenr, tabpage_label, tab_width)
  let filename = a:tabpage_label.name
  let tab_width = str2nr(a:tab_width)
  " highlight current tabpage
  let hi = a:tabpage_label.active ? '%#TabLineSel#' : '%#TabLine#'

  " `2` means insert a space to before and after label
  " e.g. `let label = ' '.filename.' '`
  let label_margin = 2
  let filename_length = strwidth(filename) + label_margin
  if filename_length > tab_width
    " Truncate filename
    let ellipsis = '...'
    let filename = filename[0:(tab_width - strwidth(ellipsis) - label_margin - 1)].ellipsis
  else
    " Append spacer
    let filename = filename . repeat(' ', tab_width - filename_length)
  endif
  let label = ' ' . filename . ' '

  " Disable tabpage label if `g:Responsive_tabline_custom_label_func` is `Funcref`
  if exists('g:Responsive_tabline_custom_label_func') && type(g:Responsive_tabline_custom_label_func) ==# type(function('tr'))
    return hi . label . '%#TabLineFill#'
  endif
  return '%' . a:tabpagenr . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! s:get_tabline_label(tabline_names)
  let width = &columns
  let tab_width = float2nr(width / len(a:tabline_names))
  return map(copy(a:tabline_names), 's:resize_label(v:key + 1, v:val, '.tab_width.')')
endfunction

function! s:get_tabpage_name(tabpagenr)
  let tabpage_buflist = tabpagebuflist(a:tabpagenr)
  let active_bufnr = tabpage_buflist[tabpagewinnr(a:tabpagenr) - 1]

  let filename = bufname(active_bufnr)
  if filename ==# ''
    let filename = '[No Name]'
  else
    let filename = fnamemodify(filename, ':t')
  endif
  let filename = a:tabpagenr.' '.filename

  let is_active = a:tabpagenr is tabpagenr()
  return { 'active': is_active, 'name': filename }
endfunction

function! s:get_tabline_names()
  return map(range(1, tabpagenr('$')), 's:get_tabpage_name(v:val)')
endfunction

function! responsive_tabline#get_tabline() abort
  let Get_tabline_names = get(g:, 'Responsive_tabline_custom_label_func', function('s:get_tabline_names'))
  let tabline_names = Get_tabline_names()
  let labels = s:get_tabline_label(tabline_names)
  let tabpages = join(labels, '') . '%#TabLineFill#%T'

  return tabpages . '%='
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
