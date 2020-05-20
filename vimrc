"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/Users/dmtrs/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/Users/dmtrs/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'derekwyatt/vim-scala.git'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'w0rp/ale'

NeoBundle 'pangloss/vim-javascript'
NeoBundle 'ryym/vim-riot'
NeoBundle 'heavenshell/vim-tslint' 

NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

" You can specify revision/branch/tag.
" NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

NeoBundle 'supercollider/scvim'
NeoBundle 'jparise/vim-graphql'

NeoBundle 'embear/vim-localvimrc'
" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------
"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

syntax enable
" colorscheme solarized-light
set background=light

set expandtab
set shiftwidth=2
set softtabstop=2
" reread file automaticaly
set autoread

let g:syntastic_javascript_checkers = ['eslint']
let g:rustfmt_autosave = 1
" au FileType javascript setl softtabstop=2 tabstop=2 shiftwidth=4 noet
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
"" Enable integration with airline.
let g:ale_fix_on_save = 1

let g:airline_theme='solarized'
let g:airline#extensions#ale#enabled = 1

let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']

let g:ale_linters =  {
  \ 'typescript': ['tslint']
  \ }
let g:ale_fixers =  {
  \ 'typescript': ['prettier','tslint'],
  \ 'javascript': ['prettier','eslint']
  \ }
let g:ale_javascript_prettier_options='--single-quote --trailing-comma es6 '

set incsearch " do incremental searching
set path=.,/usr/include,**,,

set ignorecase
set smartcase

set backupcopy=yes
