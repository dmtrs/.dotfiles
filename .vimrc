" My colors are just fine
" I use a back background in my editors
" set background=dark

" I like highlighted search results
set hlsearch
" Use incremental searching
set incsearch

" Set standard setting for PEAR coding standards
set tabstop=4
set shiftwidth=4

" Auto expand tabs to spaces
set expandtab

" Auto indent after a {
set autoindent
set smartindent

" Linewidth to endless
set textwidth=0

" Do not wrap lines automatically
set nowrap

" Show line numbers by default
" set number

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3

" Repair wired terminal/vim settings
set backspace=start,eol

" Map <CTRL>-B to run PHP parser check
noremap <C-B> :w<CR>:!php -l %<CR>

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
set dictionary-=/home/dmtrs/funclist.txt dictionary+=/home/dmtrs/funclist.txt
" Use the dictionary completion
set complete-=k complete+=k

" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
imap <C-F> <c-r>=InsertTabWrapper()<cr>

" Don't like set list
" set list
" set listchars=tab:>-,trail:-
" set listchars=tab:>-,trail:-,eol:$
set ignorecase                  " caseinsensitive searches
set showmode                    " always show command or insert mode
set ruler                      " show line and column information
set showmatch                  " show matching brackets
set formatoptions=tcqor
set whichwrap=b,s,<,>,[,]
syntax on

" CTRL-C = SVN Commit
map <C-Q> :w<CR>:!svn commit<CR>
