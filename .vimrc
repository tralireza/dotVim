""" vim: set foldmethod=marker :""" 
set modelines=1
"autocmd BufWritePost .vimrc source $MYVIMRC

imap <ESC>3 #

" General {{{1
let mapleader='\'
syntax on

set autowrite
set encoding=utf-8
set clipboard=unnamed
set number
set nowrapscan
set hidden
set foldcolumn=5
set ts=2 sts=2 sw=2 expandtab "Default Tab/Whitespace"
set listchars=eol:$,space:.,tab:»-
"set matchpairs+=<:>

filetype indent plugin on
command! -nargs=* Wrap set wrap linebreak nolist

"colorscheme morning
"colorscheme retrobox
"highlight FoldColumn ctermbg=Black ctermfg=Grey
"highlight Folded ctermfg=Black
"highlight MatchParen ctermbg=12

nmap § :set list!<CR>
map <Leader>ew :e <C-R>=expand("%:p:h")."/"<CR>

" Language {{{1
" Python {{{2
autocmd BufNewFile,BufRead *.py set ts=4 sts=4 sw=4 expandtab autoindent fileformat=unix
autocmd BufNewFile,BufRead *.py match ErrorMsg /\s\+$/
autocmd BufWritePost *.py call flake8#Flake8()

" JavaScript {{{2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 noexpandtab

" Go {{{2
autocmd FileType go setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype go iabbrev <buffer> ftst func TestX(t *testing.T) {<CR>}<ESC>?X<CR>xh

" Plugins {{{1
" NetRW {{{2
let g:netrw_liststyle=3
let g:netrw_banner=1
let g:netrw_browse_split=0

" RustVim {{{2
let g:rustfmt_autosave=1

" VimGo {{{2
let g:go_highlight_build_constraints=1
let g:go_highlight_extra_types=1
let g:go_highlight_operators=1
let g:go_highlight_functions=1
let g:go_highlight_types=1
let g:go_metalinter_autosave=1
let g:go_auto_type_info=1
let g:go_auto_sameids=0
let g:go_def_mode='gopls'
let g:go_def_reuse_buffer=1
let g:go_info_mode='gopls'
let g:go_decls_include="func,type"
let g:go_doc_popup_window=0
let g:go_term_enabled=1
let g:go_term_mode='split'
let g:go_term_reuse=1
let g:go_term_close_on_exit=0
let g:go_term_height=11
let g:go_jump_to_error=1
let g:go_test_show_name=1

if has("autocmd")
	autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')

	"autocmd FileType go nmap <Leader>d <Plug>(go-doc) "normal K
	autocmd FileType go nmap <Leader>h <Plug>(go-decls-dir)
	autocmd FileType go nmap <Leader>g <plug>(go-coverage-toggle)
	autocmd FileType go nmap <Leader>c :GoCallers<CR>
	autocmd FileType go nmap <Leader>r <Plug>(go-referrers)
	autocmd FileType go nmap <Leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>j :GoTestFunc -v<CR>
	autocmd FileType go nmap <Leader>i <Plug>(go-info)
	autocmd FileType go nmap <Leader>f <Plug>(go-fmt)
  autocmd Filetype go nmap <Leader>w <plug>(go-doc-browser)
  autocmd Filetype go nmap <Leader>y <plug>(go-sameids)
  autocmd Filetype go nmap <Leader>m <plug>(go-implements)
  autocmd Filetype go nmap <Leader>e <plug>(go-iferr)

  autocmd FileType go nmap <leader>b :<C-u>call <SID>BuildGoFiles()<CR>

  autocmd FileType go setlocal omnifunc=go#complete#Complete
  autocmd FileType go setlocal completeopt=longest,menuone
endif

function! s:BuildGoFiles()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
