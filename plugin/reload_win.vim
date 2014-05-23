" Vim plugin to reload browser in windows.
" Auther: mh_033 <y326045@yahoo.co.jp>
" (c) 2014 mh_033
" License: MIT license


scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


if exists('g:loaded_reload_win')
	finish
endif
let g:loaded_reload_win = 1


if !exists(':ReloadWin')
	command! ReloadWin call reload_win#reload_win#RInit()
endif


" Offer plugs
nnoremap <unique> <silent> <Plug>(reloadwin) :<c-u>ReloadWin<cr>
nnoremap <unique> <silent> <Plug>(reloadwin_open) 
			\	:<c-u>call reload_win#reload_win#ROpen()<cr>
nnoremap <unique> <silent> <Plug>(reloadwin_change) 
			\	:<c-u>call reload_win#reload_win#RChange()<cr>


" Default key mappings.
if !hasmapto('<Plug>(reloadwin)')
	nmap <unique> <silent> <Leader>w <Plug>(reloadwin)
endif
if !hasmapto('<Plug>(reloadwin_open)')
	nmap <unique> <silent> <Space>o <Plug>(reloadwin_open)
endif
if !hasmapto('<Plug>(reloadwin_change)')
	nmap <unique> <silent> <Space>i <Plug>(reloadwin_change)
endif


let &cpo = s:save_cpo
unlet s:save_cpo
