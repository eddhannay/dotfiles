set nocompatible
filetype off
"Must be disabled for :BundleInstall
set shellslash

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'plasticboy/vim-markdown'
Bundle 'jnurmine/Zenburn'
Bundle 'othree/xml.vim'
Bundle 'othree/html5.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'ack.vim'
Bundle 'paredit.vim'
Bundle 'tpope/vim-fireplace'
Bundle 'jiangmiao/simple-javascript-indenter'
Bundle 'pangloss/vim-javascript'
Bundle 'SirVer/ultisnips'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'vim-scripts/tComment'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'tommcdo/vim-exchange'
Bundle 'vim-scripts/BufOnly.vim'
Bundle 'b4winckler/vim-angry'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wting/rust.vim'
Bundle 'cespare/vim-toml'
Bundle "marijnh/tern_for_vim"
Bundle "Valloric/YouCompleteMe"
Bundle "vim-scripts/LoremIpsum"
Bundle "elixir-lang/vim-elixir"

call vundle#end()

let mapleader = "\<Space>"

"Indentation
filetype plugin indent on
set dir=~/.vimswap//,/var/tmp//,/tmp//,.
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set fileformats=unix,dos
set fileformat=unix
set backspace=indent,eol,start
set hidden
set ruler
set number
set colorcolumn=80
set laststatus=2
set ignorecase
set smartcase

set incsearch
set hlsearch

"Use console dialogs instead of popup for simple choices
set guioptions+=c

syntax on
set foldmethod=syntax
let g:xml_syntax_folding=1
set foldlevelstart=99

"Make :W typo do what you want
command W :w

"Folding - unfold everything by default
au BufRead * normal zR
au FileType gitcommit setlocal foldlevel=99

set completeopt+=longest
set completeopt+=menuone
set wildmenu

set path+=**
set suffixesadd+=.js,.rb,.cs,.py

set encoding=utf8

set list
set listchars=tab:›\ ,eol:¬

"Maps space to clear search highlighting
nmap <SPACE> <SPACE>:noh<CR>

set gfn=Droid_Sans_Mono_for_Powerline:h9:cANSI

set backupdir=~/.backups/vim

autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost /tmp*clj set bufhidden=delete
noremap <leader>bo :BufOnly<CR>

nmap <F2> :NERDTreeToggle<CR>

function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Gstatus
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()
nmap <F3> :ToggleGStatus<CR>

"Colorscheme settings
set background=dark
colorscheme Tomorrow-Night-Eighties 

"Make incsearch more readable
hi! IncSearch term=standout,reverse cterm=standout,reverse ctermbg=NONE

"Use local vimrc to change this per-project
set ts=4 sw=4 sts=4 et

"Use js-beautify for gq in js files
function! BeautifyJs()
    echo "calling js beautify"
    let currentET = &et
    set et
    let startline = v:lnum
    let endline = v:lnum + v:count - 1
    exe startline . "," . endline . "retab!"
    exe startline . "," . endline . " ! js-beautify -j -w 80 -f -"
    let &et = currentET
    retab!
endfunction

au FileType javascript setl formatexpr=BeautifyJs()
let g:SimpleJsIndenter_BriefMode = 1

"Allow multiple visual indents
vnoremap < <gv
vnoremap > >gv

let g:ctrlp_root_markers = ['.ctrlp_root']
let g:ctrlp_custom_ignore = '\v[\/](node_modules|bower_components|build|out|resources\/public\/out)$'

set t_Co=256
noremap <leader>d :windo ToggleDiff<CR>

set exrc
set secure