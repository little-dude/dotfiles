" TODO: steal ideas from this vimrc https://amix.dk/vim/vimrc.html

filetype off                                    " required!

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-dadbod'
Plug 'mattn/vim-sqlfmt'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
Plug 'venantius/vim-eastwood'
Plug 'elixir-editors/vim-elixir'
Plug 'cespare/vim-toml'
" Plug 'Yggdroot/indentLine'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'

" Plug 'LnL7/vim-nix'
" Plug 'rhysd/vim-rustpeg'
" Plug 'chiedo/vim-case-convert'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'                 " show signs for unstaged changes
Plug 'scrooloose/nerdtree'                    " file explorer
" Plug 'vim-scripts/tcl.vim--smithfield-indent' " tcl plugin
Plug 'joshdick/onedark.vim'                   " colorscheme
" Plug 'klen/python-mode'
" Plug 'klen/python-mode', {'branch': 'develop'} " python plugin. Using develop branch due to https://github.com/python-mode/python-mode/issues/783
Plug 'little-dude/python-mode', {'branch': 'develop'}
Plug 'tpope/vim-fugitive'                     " git wrapper
Plug 'tpope/vim-unimpaired'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'rust-lang/rust.vim'
Plug 'Glench/Vim-Jinja2-Syntax'               " Jinja2 syntax highlighting
" Plug 'tpope/vim-abolish'
Plug 'Valloric/YouCompleteMe'                 " completion
Plug 'mileszs/ack.vim'                        " to use `rg` instead of `grep`
Plug 'vim-scripts/syslog-syntax-file'
" Plug 'chaoren/vim-wordmotion'

" Plug 'AndrewRadev/splitjoin.vim'
" Plug 'cstrahan/vim-capnp'                       
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go'
" Plug 'rodjek/vim-puppet'
" Plug 'lambdatoast/elm.vim'
" Plug 'mhinz/vim-rfc'
" Plug 'vim-scripts/rfc-syntax', { 'for': 'rfc' } " optional syntax highlighting for RFC files

call plug#end()

" Tmux configuration
" See http://unix.stackexchange.com/questions/29907/how-to-get-vim-to-work-with-tmux-properly
" if &term =~ '^screen'
"     execute "set <xUp>=\e[1;*A"
"     execute "set <xDown>=\e[1;*B"
"     execute "set <xRight>=\e[1;*C"
"     execute "set <xLeft>=\e[1;*D"
" endif

set noeb vb t_vb=         " Disable all fucking bells
set showmatch             " Show matching brackets.
set mat=1                 " When typing ')', highlight the matching '(' (also work with [] and {})
set wildmode=longest,list " bash completion
set scrolloff=5           " 5 line above / below the cursor when scrolling
set cursorline            " show the line on which the curso is
set hidden                " Don't have to save the buffer all the time
set pastetoggle=<F3>      " Avoid indentation when pasting

set mousefocus
set number

" Colors
set background=dark
colorscheme onedark
" transparent background
highlight Normal ctermbg=none
" colors tabs
highlight IndentGuidesOdd  ctermbg=none
highlight IndentGuidesEven ctermbg=none
" colors in visual mode
highlight Visual term=reverse cterm=reverse
" colors in completion menu
highlight Pmenu term=reverse ctermbg=white
" colors of line numbers
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=none gui=none guifg=Grey guibg=NONE
" highlight ExtraWhitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" Show trailing whitepace and spaces before a tab:
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\|\t\+/
autocmd Syntax * syn match ExtraWhitespace /\s\+$/

set ignorecase                              " Do case insensitive matching
set smartcase                               " Do smart case matching

set foldenable                              " Enable folding
set foldmethod=syntax                       " Automatic folding depending based on language
set foldlevelstart=2                        " Start folding at lvl 2
let tcl_fold=1                              " Add folding for tcl

set expandtab                               " use soft tabs (spaces)
set tabstop=4                               " 1 tab is 4 spaces large
set softtabstop=0                           " use tabstop value for soft tabs
set shiftwidth=0                            " use tabstop value for hard tabs

" normal mode by pressing jk.
map! jk <ESC>
tnoremap jk <C-\><C-n>
" select the text that was last edited/pasted
nmap gV `[v`]

" define a new leader key.
let mapleader=","

" stop search
map no :nohlsearch<CR>

if executable('rg')
    let g:ackprg = 'rg --vimgrep'
endif
" search using fzf
map <F4>  :execute "Find" expand("<cword>")<CR>
" search using ripgrep and the quickfix window. use [q and ]q to navigate the
" quickfix window, and \x to close it
nmap <F5> :Ack! "\b<cword>\b" <CR>
nmap \x :cclose<CR>

" when editing a file without the right permission, we can't save it. This is a shortcut to get sudo rights to write the file
cmap w!! w !sudo tee >/dev/null %

" Bubbling Text (see : http://unix.stackexchange.com/questions/1709/how-to-fix-ctrl-arrows-in-vim)
" Single line bubbling with arrow UP and arrow DOWN
nmap <C-Up>   [e
nmap <C-Down> ]e
" Multiple line bubbling with arrow UP and arrow DOWN
vmap <C-Up>   [egv
vmap <C-Down> ]egv



" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Copy/paste
nmap <C-p> "+p
nmap <C-y> "+yy
vmap <C-d> "+d
vmap <C-p> d$"+p
vmap <C-y> "+y

" move to upper split
nnoremap <C-k> <C-w>k
" move to lower split
nnoremap <C-l> <C-w>l
" move to left split
nnoremap <C-h> <C-w>h
" move to right split (dump remap necessary because vim-latex imaps plugin already maps ctrl-j...)
nnoremap <SID>I_wonâ€™t_ever_type_this <Plug>IMAP_JumpForward
nnoremap <C-j> <C-w>j
" resize split
nnoremap + <C-w>+
" we use this one to go to beginning of the line
" nnoremap - <C-w>-
nnoremap > <C-w>>
nnoremap < <C-w><


" Plugins configuration

" NerdTree
nnoremap <silent> <F9> :NERDTreeToggle<CR>
nnoremap <silent> <F10> :NERDTreeFind<CR>

" pymode
let g:pymode_indent = 1                     " let pymode handle indentation
let g:pymode_rope = 0                       " disable rope since it slows down vim like crazy on big projects
let g:pymode_rope_lookup_project = 0        " made useless by disabling rope, but I keep it here to remember
let g:pymode_python = 'python3'
" see https://stackoverflow.com/a/27613274/1836144
let g:pymode_options_max_line_length = 79
autocmd FileType python set colorcolumn=79

" fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" YCM
let g:ycm_rust_src_path = '/home/corentih/.multirust/sources/rustc-nightly/src'

" requires powerline-fonts to be installed
let g:airline_powerline_fonts = 1

" sum numbers
" http://vim.wikia.com/wiki/Sum_numbers
let g:S = 0  "result in global variable S
function! Sum(number)
  let g:S = g:S + a:number
  return a:number
endfunction

autocmd Filetype gitcommit setlocal spell textwidth=72

" For this to work in tmux see https://github.com/neovim/neovim/wiki/FAQ#cursor-shape-doesnt-change-in-tmux
" And `:help guicursor`
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

" let g:rustfmt_autosave = 1
let g:wordmotion_prefix = ','

" FZF
"
" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)

nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>f :Find 

hi Folded ctermfg=101

let g:syntastic_rust_checkers = ['cargo', 'rustc']
" disable syntastic for rust and python by default
" See https://stackoverflow.com/a/19230383/1836144
let g:syntastic_mode_map = { "passive_filetypes": ["python", "rust"] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" https://github.com/Yggdroot/indentLine
let g:indentLine_enabled = 0 " disabled by default, it's useful on shitty scripts with 6+ levels of indentation
"
" indentLine will overwrite 'conceal' color with grey by default. If you want
" to highlight conceal color with your colorscheme, disable by:
let g:indentLine_setColors = 0
let g:indentLine_char = 'â”†'


" let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
" https://remarkablemark.org/blog/2016/09/28/vim-syntastic-eslint/
" let g:syntastic_javascript_checkers=['eslint']
" https://github.com/vim-syntastic/syntastic/issues/1692#issuecomment-241672883
" NOTE THAT ESLINT MUST *ALSO* BE INSTALLED GLOBALLY AND AVAILABLE IN THE
" PATH:
" https://github.com/vim-syntastic/syntastic/issues/1692#issuecomment-247240708
let g:syntastic_javascript_eslint_exe='$(yarn bin)/eslint'
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_clojure_checkers = ['eastwood']
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

let @c = '^dwve~Iconst jkt:ld$A: Field = k$T=t;yiwjA"..="+4;j'
let @r = '^ea fnjkt:vb"nyelxi(&self) ->$xA {o}ONativeEndian::read_k$T>lveyj$pA(&self.buffer.as_ref()["€kb"npvb~A])joj'
let @w = '^ea dn€kb€kbfnt:biset_lve"nyt:lxi*€kb(&mut self, value:$r)A {NativeEndian::write_k$T)hhyiwj$pA(&mut self.buffer.as_mut()[nvb~A], value){€kb}j'
let @p = '^dw"nyt:t ld$A self.n(),j'
let @e = '^dwibuffer.set_lveyea(self.")ld$A;j'

set termguicolors

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Maps K to hover, gd to goto definition, F2 to rename
nnoremap <silent> K :call LanguageClient_textDocument_hover()
nnoremap <silent> gd :call LanguageClient_textDocument_definition()
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()
