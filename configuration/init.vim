"-------------------------------------------------------------------------------
" Override default configs
"-------------------------------------------------------------------------------
set number " Adds line numbers
set autoindent " On new line, match indent
set mouse=a " Add mouse support
syntax on " Highlight syntax enabled
set wildignore+=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx, " Set files to ignore
set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk " Set folders to ignore
" Set tab configs
set tabstop=4 " Number of spaces a <tab> in a file counts for
set shiftwidth=4 " Changes the indent when using >>, <<, and ==
set softtabstop=4 " Something smart, just keep it the same as `tabstop`. This makes no difference if `shiftwidth` is the same as `tabstop`... i think
set expandtab " Pressing tab key inserts indentation according to `shiftwidth`
set smarttab " Pressing tab considers current cursor context/position

"-------------------------------------------------------------------------------
" Setup plugins
"-------------------------------------------------------------------------------
call plug#begin()

    " Conquer of Completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Lightline
    Plug 'itchyny/lightline.vim'

    " Git
    Plug 'mhinz/vim-signify'

    " Themes
    Plug 'safv12/andromeda.vim'
    Plug 'rebelot/kanagawa.nvim'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }

    " Comments
    Plug 'numToStr/Comment.nvim'

    " Better Whitespace
    Plug 'ntpeters/vim-better-whitespace'

    " Git Diff tool
    Plug 'sindrets/diffview.nvim'

    " NERD
    Plug 'preservim/nerdtree'

call plug#end()

lua require('Comment').setup()
lua require('telescope').setup{  defaults = { file_ignore_patterns = { ".git" }} }

"-------------------------------------------------------------------------------
" Theme
"-------------------------------------------------------------------------------
colorscheme kanagawa-dragon

"-------------------------------------------------------------------------------
" Terminal
"-------------------------------------------------------------------------------
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            if has("win32") || has("win64")
                call termopen("powershell.exe", {"detach": 0})
            else
                call termopen($SHELL, {"detach": 0})
            endif
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

"-------------------------------------------------------------------------------
" Autocomplete drop down
"-------------------------------------------------------------------------------
" Rebind to tab
" inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"

"-------------------------------------------------------------------------------
" NERDTree Configs
"-------------------------------------------------------------------------------
let g:NERDTreeHijackNetrw = 1
let NERDTreeShowHidden=1
let NERDTreeMapActivateNode='<space>'
let g:NERDTreeWinPos = "right"
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]

"-------------------------------------------------------------------------------
" NERDTree Configs
"-------------------------------------------------------------------------------
let g:coc_global_extensions = ['coc-json', 'coc-rust-analyzer', 'coc-highlight']
let g:coc_disable_startup_warning = 1
" Controls-sorta
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

"-------------------------------------------------------------------------------
" Controls
"-------------------------------------------------------------------------------
" Telescope
noremap ? :Telescope find_files hidden=true<CR>
noremap ' :Telescope live_grep<CR>

" NERD Tree
noremap <F3> :NERDTreeToggle<CR>

" Navigation
map h <Up>
map j <Down>
map k <Left>
map l <Right>

" hjkl Binds
" Window Navigation
noremap <C-h> <C-w><Up>
noremap <C-j> <C-w><Down>
noremap <C-k> <C-w><Left>
noremap <C-l> <C-w><Right>

" Tab navigation
nnoremap <C-S-k> :tabprev<CR>
nnoremap <C-S-l> :tabnext<CR>

" Arrows Binds
" Window Navigation
noremap <C-Up> <C-w><Up>
noremap <C-Down> <C-w><Down>
noremap <C-Left> <C-w><Left>
noremap <C-Right> <C-w><Right>
" Tab navigation
nnoremap <C-S-Left> :tabprev<CR>
nnoremap <C-S-Right> :tabnext<CR>

" CoC Completion/Suggestion
inoremap <silent><expr> <c-space> coc#refresh()

" Terminal Functionality
"" Toggle terminal on/off
nnoremap <F2> :call TermToggle(12)<CR>
inoremap <F2> <Esc>:call TermToggle(12)<CR>
tnoremap <F2> <C-\><C-n>:call TermToggle(12)<CR>
"" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" Git Diff view
nnoremap <leader>g :DiffviewOpen<cr>
nnoremap <leader>G :DiffviewClose<cr>

