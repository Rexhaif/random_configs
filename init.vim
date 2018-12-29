if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) " install vim-plug if it's not present
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
syntax enable
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')  " setup for vim-plug
    Plug 'junegunn/vim-plug'                    " for documentation only
    Plug 'vim-airline/vim-airline'              " improved statusline
    Plug 'scrooloose/nerdtree'                  " file system explorer
    Plug 'Xuyuanp/nerdtree-git-plugin'          " NERDTree plugin showing git status flags
    Plug 'mbbill/undotree'                      " undo history visualizer
    Plug 'mhinz/vim-signify'                    " show changes in files under VCS
    Plug 'gko/vim-coloresque'                   " for color highliting: red
    Plug 'edkolev/tmuxline.vim'                 " tmux support
    Plug 'vim-syntastic/syntastic'              " syntax checking
    Plug 'editorconfig/editorconfig-vim'        " .editorconfig support
    Plug 'tpope/vim-fugitive'                   " support for git
    Plug 'joshdick/onedark.vim'                 " theme
    Plug 'cocopon/iceberg.vim/'                 " theme
    Plug 'terryma/vim-multiple-cursors'         " multicursor suport
    Plug 'rust-lang/rust.vim'                   " rust lang support
    Plug 'kballard/vim-swift'                   " swift lang support
    Plug 'cjrh/vim-conda'                       " conda support
    "Plug 'vim-airline/vim-airline-themes'      "*theces for Airline
    "Plug 'blueshirts/darcula'                  "*theme
    "Plug 'neomake/neomake'
    "Plug 'tpope/vim-sensible'
    "Plug 'dbakker/vim-lint'
    "Plug ''
call plug#end()

autocmd VimEnter * " install mising plugins
    if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        PlugInstall --sync | q
    endif

"colorscheme onedark
"let g:airline_theme='onedark'

colorscheme iceberg
let g:airline_theme='iceberg'

"function! s:plug_gx()
"    let line = getline('.')
"    let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
"    let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
"                        \ : getline(search('^- .*:$', 'bn'))[2:-2]
"    let _uri  = get(get(g:plugs, name, {}), 'uri', '')
"    let uri = 'https://github.com/' + uri_
"    if uri !~ 'github.com'
"        return
"    endif
"    let repo = matchstr(uri, '[^:/]*/'.name)
"    let url  = empty(sha) ? 'https://github.com/'.repo
"                        \ : printf('https://github.com/%s/commit/%s', repo, sha)
"    call netrw#BrowseX(url, 0)
"endfunction
"
"augroup PlugGx
"    autocmd!
"    autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
"augroup END

set ignorecase
set smartcase
set gdefault

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-f> :NERDTreeToggle<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set number
set showmatch
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

"=== SHIULD BE DELETED AFTER EDITORCONFIG CONNECTED ===

set tabstop=4
set expandtab
set shiftwidth=4

