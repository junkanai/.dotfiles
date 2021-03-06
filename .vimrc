" Shortcuts
autocmd FileType python nnoremap smain iif<space>__name__<space>==<space>"__main__":<CR>main()<ESC>
tnoremap ;c make<space>main<CR>
tnoremap ;a ./a.out<CR>
tnoremap ;m ./main<CR>

"General settings"
syntax on
set nocompatible
set noswapfile
set t_Co=256
set encoding=utf-8
set whichwrap=b,s,h,l,<,>,[,],~
set clipboard=unnamed

set number
set scrolloff=5

set tabstop=4
set autoindent
set smartindent
set breakindent
set shiftwidth=4

set list
set listchars=tab:\|\ ,trail:_

filetype on

set ambiwidth=double
set incsearch
set ignorecase
set smartcase
set pumheight=10
set virtualedit=onemore
set wildmenu
set foldmethod=indent
""set foldmethod=expr
set foldlevel=100
set history=1000
set viminfo='20,\"1000

" Statusline "
function! MyStatusLine()
	if expand('%:t') ==# ''
		let filename = '[No Name]'
	else
		let dirfiles = split(expand('%:p'), '/')
		if len(dirfiles) < 2
			let filename = dirfiles[0]
		elseif dirfiles[-1] == 'bash'
			let filename = 'Terminal'
		else
			let filename = dirfiles[-2] . ' / ' . dirfiles[-1]
		endif
	endif
	return filename
endfunction

set laststatus=2
set statusline=\ \ %{MyStatusLine()}%=%m[%l/%L][%v]%y

" ColorSchemes "
autocmd ColorScheme * highlight StatusLine ctermfg=230 ctermbg=98 cterm=bold
autocmd VimEnter * highlight StatusLine ctermfg=white ctermbg=230 ctermbg=98 cterm=bold
autocmd InsertEnter * highlight StatusLine ctermfg=white ctermbg=brown cterm=bold
autocmd InsertLeave * highlight StatusLine ctermfg=white ctermbg=230 ctermbg=98 cterm=bold

" Tabline "
let g:is_vaffle = 0
autocmd FileType vaffle let g:is_vaffle = 1

function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		if i + 1 == tabpagenr() 
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		if i + 1 == tabpagenr()
			let s .= ' %#TabLineSel#'
		else
			let s .= ' %#Title#'
		endif
		let n = ''
		let buflist = tabpagebuflist(i+1)
		for b in buflist
			if getbufvar(b, "&modifiable")
				let n .= fnamemodify(bufname(b), ':t') . ', '
			endif
		endfor
		let n = substitute(n, ', $', '', '')
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif
		if n == ''
			if g:is_vaffle
				let s .= 'Vaffle'
			else
				let s .= '[No Name]'
			endif
		else
			let s .= n
			let g:myfilename = n
		endif

		let s .= ' '
	endfor
	let s .= '%#TabLineFill#%T'
	return s
endfunction

set showtabline=2
set tabline=%!MyTabLine()

autocmd ColorScheme * highlight TabLine ctermfg=247 ctermbg=234
autocmd ColorScheme * highlight TabLineSel term=bold ctermfg=230 ctermbg=247

" Cursor "
if has ('vim_starting')
	let &t_SI .= "\e[5 q"
	let &t_EI .= "\e[2 q"
	let &t_SR .= "\e[4 q"
endif

" shortcuts in normal mode
" noremap = nnoremap + vnoremap
" noremap! = cnoremap + inoremap
let mapleader = "\<space>"
noremap <space> <nop>
onoremap <space> <nop>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
noremap <leader>h ^
noremap <leader>l $

nnoremap <leader>f :e<space>.<CR>
nnoremap <leader>t :bo<space>term++rows=10<CR>
nnoremap <leader>s :vs<CR><c-w>l:Vaffle<CR>
nnoremap <leader>n :tabe<CR>:Vaffle<CR>
nnoremap <leader>. :tabe ~/.vimrc<CR>
nmap <leader>r <space>w<c-j>;r
nnoremap <leader>z za

"leader + m is being used for highlight"
"leader + j or k is being used for easymotion

nnoremap <leader>cy "uyiw:hi link foo Type<CR>:hi clryellow ctermfg=214 ctermbg=256<CR>:syntax keyword clryellow <c-r>"<CR>
nnoremap <leader>cb "uyiw:hi link foo Type<CR>:hi clrblue ctermfg=109 ctermbg=256<CR>:syntax keyword clrblue <c-r>"<CR>
nnoremap <leader>cr "uyiw:hi link foo Type<CR>:hi clrred ctermfg=167 ctermbg=256<CR>:syntax keyword clrred <c-r>"<CR>
nnoremap <leader>cg "uyiw:hi link foo Type<CR>:hi clrgreen ctermfg=142 ctermbg=256<CR>:syntax keyword clrgreen <c-r>"<CR>
nnoremap <leader>cw "uyiw:hi link foo Type<CR>:hi clrwhite ctermfg=223 ctermbg=256<CR>:syntax keyword clrwhite <c-r>"<CR>

" shortcuts in insert mode "
inoremap jk <ESC>
cnoremap jk <ESC><ESC>
noremap! jf <c-h>
noremap! kd <c-w>

inoremap ( ()<left>
inoremap (<space> (<space><space>)<left><left>
inoremap [ []<left>
inoremap " ""<left>
inoremap { {}<left>
inoremap {<space> {<space><space>}<left><left>
inoremap {J {<CR>}<ESC>O
nnoremap {J C{<CR>}<ESC>O<ESC>p=l

nnoremap gs :%s///g<left><left><left>
vnoremap gs :s///g<left><left><left>
nnoremap v <c-v>
nnoremap <c-v> v
nnoremap <c-z> <nop>
noremap! <c-l> <right>

nnoremap j gj
nnoremap k gk
nnoremap L gt
nnoremap H gT
noremap J 20j
noremap K 20k
nnoremap gj J
onoremap ad a"
onoremap id i"

nmap <c-l> <c-w>l
nmap <c-j> <c-w>j
nmap <c-h> <c-w>h
nmap <c-k> <c-w>k

cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-h> <left>
cnoremap ; <space><c-h>

nnoremap x "_x
nnoremap X "_X

tnoremap ;f exit<CR>
tnoremap ;n <c-w>N
tnoremap ;t <c-w>"+
autocmd FileType python tnoremap ;r <c-w>k:let @+ = expand('%:t')<CR><c-w>jpython <c-w>"+<CR>
autocmd FileType cpp tnoremap ;r <c-w>k:let @+ = expand('%:t')<CR><c-w>jg++ <c-w>"+<CR>
tnoremap <c-n> <c-p>
tnoremap <c-p> <c-n>
tnoremap <c-l> <right>
tnoremap <c-j> <c-w>j
tnoremap <c-h> <left>
tnoremap <c-k> <c-w>k

" Plugins "
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'cocopon/vaffle.vim'
Plug 'machakann/vim-sandwich'
Plug 'easymotion/vim-easymotion'
Plug 't9md/vim-quickhl'
Plug 'simeji/winresizer'
Plug 'LeafCage/yankround.vim'
Plug 'pseewald/vim-anyfold'

call plug#end()


" Vaffle "
let g:vaffle_auto_cd = 1
function! s:customize_vaffle_mappings() abort
	nmap <buffer> u <Plug>(vaffle-toggle-current)
	"copy a file
	nmap <buffer> y l:%y<CR><space>f
endfunction

augroup vimrc_vaffle
	autocmd!
	autocmd FileType vaffle call s:customize_vaffle_mappings()
augroup END

" EasyMotion "
let g:EasyMotion_smartcase = 1
map ; <Plug>(easymotion-bd-f)
map t <Plug>(easymotion-bd-t)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
let g:EasyMotion_keys = 'jfkdhgwertuiocvnmsla;'
nmap <leader>v V<Plug>(easymotion-j)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)

"Surround"
runtime macros/sandwich/keymap/surround.vim
nmap p <Plug>(yankround-p) ']
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <c-p> <Plug>(yankround-prev)
nmap <c-n> <Plug>(yankround-next)
let g:yankround_max_history = 63

"QuickHighLight"
nmap <leader>m <Plug>(quickhl-manual-this)
xmap <leader>m <Plug>(quickhl-manual-this)
nmap <leader>M <Plug>(quickhl-manual-reset)
xmap <leader>M <Plug>(quickhl-manual-reset)

"WinResizer"
let g:winresizer_start_key = '<c-t>'
let g:winresizer_keycode_cancel = '<c-t>'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 1

"AnyFold"
filetype plugin indent on
autocmd FileType * AnyFoldActivate

" ColorScheme "
autocmd ColorScheme * highlight Normal ctermbg=256
autocmd ColorScheme * highlight Comment ctermfg=105
autocmd ColorScheme * highlight LineNr ctermfg=8
autocmd ColorScheme * highlight String ctermfg=175
autocmd ColorScheme * highlight Pmenu ctermfg=251 ctermbg=236
autocmd ColorScheme * highlight PmenuSel ctermfg=235 ctermbg=152 cterm=None
autocmd ColorScheme * highlight PmenuSbar ctermbg=240
autocmd ColorScheme * highlight PmenuThumb ctermbg=140
autocmd ColorScheme * highlight Include ctermfg=109
autocmd ColorScheme * highlight Macro ctermfg=109
autocmd ColorScheme * highlight PreCondit ctermfg=109
autocmd ColorScheme * highlight Operator ctermfg=7
autocmd ColorScheme * highlight Search cterm=bold ctermfg=196 ctermbg=256
autocmd ColorScheme * highlight EasymotionTargetDefault cterm=bold ctermfg=196
autocmd ColorScheme * highlight EasymotionShade ctermfg=239 ctermbg=256
autocmd ColorScheme * highlight Folded ctermfg=223 ctermbg=239

syn keyword cppType vector array valarray string
syn keyword cppStatement rep

colorscheme gruvbox
set background=dark

" complement "
set completeopt=menuone

for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor

imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"
