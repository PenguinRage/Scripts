""" VIM Hybrid Coding Config
" Description: Optimized for C/C++ development, Expanding out and replacing stuff as I go.
" Author: Ian Cleasby
"
"-----------------------------------------------------------------------------------------
" Management:
"-----------------------------------------------------------------------------------------
syntax on
colorscheme desert

set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set encoding=utf-8
" use indentation of previous line
"set autoindent
" use intelligent indentation for C
set smartindent

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" turn line numbers on
set number
" highlight matching braces
set showmatch

Plugin 'VundleVim/Vundle.vim' "package manager
Plugin 'vim-scripts/Conque-GDB' "GDB in vim
Plugin 'godlygeek/tabular' "Aligning 
Plugin 'tpope/vim-git' "git usage
Plugin 'tpope/vim-surround' "surround parenthesis
Plugin 'scrooloose/nerdtree'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'mrtazz/DoxygenToolkit.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'moll/vim-node'
Plugin 'itchyny/vim-haskell-indent'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
let g:airline_theme='ravenpower'
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
"-------------------------------------------------------------------------------
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
"-------------------------------------------------------------------------------
" Nerd Tree if and only if no file has been given
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
set textwidth=120
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Rainbow Braces
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['yellow',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['yellow',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
"Auto implement
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>
" recreate tags file with F5

""map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>

"" Python, Haskell & Lisp run options
map <silent> <F5> :!clear;python %<CR>
map <S-F5> :w <CR> :!clear;swipl -f %<CR>

" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :make<CR>
" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" compile and run program"
map <F8> :w <CR> :!clang -g -Wall -Werrror  -march=native -lm  -pthread % -o %< && clear && ./%< <CR>
map <M-Down> ]s
map <M-Up> [s
nmap s <Plug>(easymotion-s2)

" Powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1 
let g:syntastic_python_checkers = ['pylint', 'pep8']
let g:syntastic_asm_checkers = ['nasm']
let g:syntastic_haskell_checkers = ['ghci']
" GDB
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly 
