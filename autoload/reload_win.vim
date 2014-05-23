scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let g:ReloadWin = 0

function! s:rw()
""	cd $vim\vimfiles\autoload\reload_win
	cd $RELOADWIN
	silent r !reload_win
endfunction

function! reload_win#reload_win#RInit()
	let tail = "\\vimfiles\\autoload\\reload_win"
	if isdirectory($VIM . tail)
		let $RELOADWIN = $VIM . tail
	elseif isdirectory($HOME . tail)
		let $RELOADWIN = $HOME . tail
	endif

	if g:ReloadWin
		autocmd! BufWritePost *
		let g:ReloadWin = 0
	else 
		autocmd! BufWritePost * call s:rw()
		let g:ReloadWin = 1
	endif
endfunction

" =============================================
function! reload_win#reload_win#ROpen()
	""cd $vim\vimfiles\autoload\reload_win
	cd $RELOADWIN
	let fl = readfile("_reloadwrc", "b")
	if len(fl) == 1
		let res = inputlist(['Select browser:', '1. Chrome', '2. Internet Explorer',
					\	'3. Firefox', '4. Opera', '5. safari'])
		call add(fl, res . "\r\r")
		call writefile(fl, "_reloadwrc", "b")
	else
		let res = fl[1]
	endif
	if res == 1
		let browser = '"C:\Program Files\Google\Chrome\Application\chrome"'
	elseif res == 2
		let browser = '"C:\Program Files\Internet Explorer\iexplore"'
	elseif res == 3
		let browser = '"C:\Program Files\Mozilla Firefox\firefox"'
	elseif res == 4
		let browser = '"C:\Program Files\Opera\launcher"'
	elseif res == 5
		let browser = '"C:\Program Files\Safari\Safari"'
	else 
		let browser = "rundll32 url.dll,FileProtocolHandler"
	endif

	cd %:h
	if !res || res < 5
		exe "silent !" . browser . " " . expand("%:p")
	else
		exe "silent !start " . browser . " " . expand("%:p")
		"exe "silent !start " . browser . " " . expand("%:t")
	endif
	cd $vim\vimfiles\autoload\reload_win
	silent r !reload_win 
endfunction

function! reload_win#reload_win#RChange()
	let newfl = ["", ""]
	let res = inputlist(['Select browser:', '1. Chrome', '2. Internet Explorer',
				\	'3. Firefox', '4. Opera', '5. safari'])
	let newfl[1] = res . "\r\r"
	cd $vim\vimfiles\autoload\reload_win
	call writefile(newfl, "_reloadwrc", "b")

endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
