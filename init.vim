"===== vim-plug setup =====
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) " install vim-plug if it's not present
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let &t_EI .= "\<Esc>[6 q"
call plug#begin('~/.local/share/nvim/plugged')  " setup for vim-plug
    Plug 'junegunn/vim-plug'                    " for documentation only
    Plug 'vim-airline/vim-airline'              " improved statusline
    "Plug 'vim-airline/vim-airline-themes'      "*themes for Airline
    Plug 'scrooloose/nerdtree'                  " file system explorer
    Plug 'Xuyuanp/nerdtree-git-plugin'          " NERDTree plugin showing git status flags
    Plug 'mbbill/undotree'                      " undo history visualizer
    Plug 'mhinz/vim-signify'                    " show changes in files under VCS
    Plug 'gko/vim-coloresque'                   " color highliting: red
    Plug 'edkolev/tmuxline.vim'                 " tmux support
    " Plug 'vim-syntastic/syntastic'              " syntax checking
    Plug 'editorconfig/editorconfig-vim'        " .editorconfig support
    Plug 'tpope/vim-fugitive'                   " support for git
    Plug 'joshdick/onedark.vim'                 " theme
    Plug 'cocopon/iceberg.vim/'                 " theme
    Plug 'chriskempson/base16-vim'              " theme
    Plug 'terryma/vim-multiple-cursors'         " multicursor suport
    Plug 'rust-lang/rust.vim'                   " rust lang support
    Plug 'kballard/vim-swift'                   " swift lang support
    Plug 'cjrh/vim-conda'                       " conda support
    Plug 'scrooloose/nerdcommenter'             " coment lines
    Plug 'machakann/vim-highlightedyank'        " highlight yanked area
    Plug 'neomake/neomake'
    Plug 'w0rp/ale'
    Plug 'Valloric/YouCompleteMe', {'do': './install.py --rust-completer'}
    "Plug 'tpope/vim-sensible'
    "Plug 'dbakker/vim-lint'
    "Plug ''
call plug#end()

autocmd VimEnter * " install mising plugins
    if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        PlugInstall --sync | q
    endif

"===== theme setup ====="
set termguicolors
let base16colorspace=256
colorscheme base16-atelier-lakeside
let g:airline_theme='iceberg'

"===== prefered settings ====="
set autoindent
set backup
set backupdir=~/.backup
set ignorecase
set smartcase
set gdefault
set showcmd
set scrolloff=7
set nowrap
set number
set showmatch
set guicursor=
set incsearch
set autowrite
set whichwrap+=<,>,[,]
set wildmenu
set wildignore+=*.a,*.o,.git,*~,*.swp,*.tmp
" set wildmode=list:longest,full
set nojoinspaces
set list listchars=trail:•,nbsp:≡,tab:│-,extends:»
set textwidth=140
set colorcolumn=+1
set lazyredraw
set showmode
set cul
set relativenumber
set helplang="en"
set fileencodings=utf-8
set fileformat=unix
set ttimeout
set ttimeoutlen=100

"===== edit/open commands =====
command EditNvim    :edit ~/.config/nvim/init.vim
command EditZsh     :edit ~/.zshrc

"===== save and exit =====
noremap     <C-s>   :w<CR>
inoremap    <C-s>   <Esc>:w<CR>
"noremap     <C-S>   :wa<CR>
"inoremap    <C-S>   <Esc>:wa<CR>
noremap     <C-q>   :wq<CR>
inoremap    <C-q>   <Esc>:wq<CR>
"noremap     <C-Q>   :wa<CR>:qa<CR>
"inoremap    <C-Q>   <Esc>:wa<CR>:qa<CR>

"===== quicker window movement =====
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"===== get off my lawn =====
"nnoremap <Left>     :echoe "Use h"<CR>
"nnoremap <Down>     :echoe "Use j"<CR>
"nnoremap <Up>       :echoe "Use k"<CR>
"nnoremap <Right>    :echoe "Use l"<CR>

"===== remove whitespaces =====
function ShowSpaces(...)
    let @/='\v(\s+$)|( +\ze\t)'
    let oldhlsearch=&hlsearch
    if !a:0
        let &hlsearch=!&hlsearch
    else
        let &hlsearch=a:1
    end
    return oldhlsearch
endfunction
command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)

function TrimSpaces() range
    let oldhlsearch=ShowSpaces(1)
    execute a:firstline.",".a:lastline."substitute ///gec"
    let &hlsearch=oldhlsearch
endfunction
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

"===== NERDCommenter configs =====
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

"===== NERDTree configs =====
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-f> :NERDTreeToggle<CR>

"===== neomake setup =====
call neomake#configure#automake('nrwi', 100)
let g:neomake_open_list = 2

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

"===== airline configs =====
let g:airline_powerline_fonts = 1 " custom charackters for better looks
let g:airline#extensions#tabline#enabled = 1 " Airline support for tabline
let g:airline#extensions#tabline#formatter = 'unique_tail' " format of tab names
let g:tmuxline_preset = {
            \'a':'#S',
            \'b':'#F',
            \'c':'#W',
            \'win':['#I', '#W'],
            \'cwin':['#I', '#W'],
            \'x':'%a',
            \'y':['%b %d', '%R'],
            \'z':'#H'
            \}

"==== default settings, overwritten by editorconfig =====
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

