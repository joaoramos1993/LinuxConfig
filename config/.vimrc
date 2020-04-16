"mostra numeros
set number

"Spell Check
"setlocal spell spelllang=en_us

" Filetype detection
filetype on

" Don't emulate Vi, you're VIM
set nocompatible

"hopefuly fixes the delete problem
fixdel

"Ensure correct delete/backspace mapping, even from ssh
set t_kb=
set t_kD=[3~
set backspace=indent,eol,start

" Enable syntax
syntax enable 
syntax on

"Make backup file
set backup

"Display cursor position in lower right corner
set ruler

"Backspace works?
set backspace=2

"Show matching braces
set showmatch

"Half-second blink for matching brace
set mat=5

" NO to Auto indent
set ai

" NO to Smart indent
set nosi

"c-style indenting
"set cindent

"Soft Tab stops = 4 spaces
set ts=4
set sts=4
"4 spaces fpr each step on indent
set sw=4

"Don't wrap the text
set nowrap

set tags=/vob/ios/sys/tags,/vob/ios.comp/tags,/vob/td_sml/tags,tags,/auto/ios-snaps2/snaps/haw_t/ios/tags

" expand tab to spaces
set expandtab

" Display match for a seach pattern when halfway typing
set incsearch

" Highlight search results
set hls

" activate netrw
"set nocp
"if version >= 600
"    filetype plugin indent on
"endif

" <cr> behaviour in explorer
let g:netrw_browse_split=4

" user f to show function name
map f :call ShowFuncName() <CR>

function ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

let g:explVertical=1
let g:explSplitRight=1
" use Ctrl-e to open explore
nmap <c-e> :vsplit<CR>30<c-w>\|:Explore<CR>
imap <c-e> <esc>:vsplit<CR>30<c-w>\|:Explore<CR>

let g:explHideFiles='^\.,\.gz$,\.exe$,\.zip$'

" use Ctrl-x to exit
nmap <c-x> :q<CR>
imap <c-x> <esc>:q<CR>

" user Ctrl-v to paste
nmap <c-v> "*p<CR>
imap <c-v> <esc>"*p<CR>a

" map <c-spc> to <esc> because <c-spc> is mapped to <nul> :)
imap <Nul> <Esc>

" Use tab to go to next window
map <tab> <c-w>w
" user shift-tab to go to previous window
map <s-tab> <c-w>W

" + and - to increase and decrease current window
map + <c-w>+
map - <c-w>-

"(TBD--doesn't work) -- to minimize
"map -- <c-w>l_

" ++ to maximize
map ++ <c-w>_

" == to restore
map == <c-w>=

" (TBD--doesn't work) Auto keyword complete 
"imap <c-right> <c-x><c-]>

vmap <space> zf

"From :help cscope-suggestions
if has("cscope")
    set csprg=/router/bin/cscope
    set csto=0
    
    set cst
    au BufRead,BufNewFile *.san set nocst
    set nocsverb
    let curdir=getcwd()

    cs kill 0

    " add any database in current directory
    if 1 == filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    else
       "echo curdir
       "echo "no cscope found" 
    endif
    
    set csverb
endif

" Cscope mappings
map <c-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
map <c-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
map <c-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
map <c-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
map <c-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
map <c-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
map <c-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
map <c-\>i :cs find i <C-R>=expand("<cword>")<CR><CR>
map <c-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Collapse current block
function ToggleFold()
    if 0 == foldlevel('.')
        let curline = line('.')
        normal [{
        let start = line('.') + 1
    
        normal %
        let end = line('.') - 1

        if (start < end)
            execute start
            if 0 == foldlevel('.')
                execute start . "," . end . " fold"
                execute start - 1
                echo "fold: " . start . "-" . end
            else
                normal zd
                echo "fold deleted"
            endif
        else
            execute curline
            echo "not enough lines to fold"
        endif
    else
        normal zd
        echo "fold deleted"
    endif
endfunction

" Fold all blocks in the file
function FoldAll()
    normal gg

    let prev = line('.')
    normal ]]
    let cur = line('.')

    while (prev < cur)

        if 0 == foldlevel('.')
            let start = cur + 1
            normal %
            let end = line('.') - 1
            if (start < end)
                execute start . "," . end . " fold"
                execute end + 1
            endif
        endif

        let prev = cur
        normal ]]
        let cur = line('.')

    endwhile
    normal gg
    echo "done"
endfunction

" expand current block
function UnFoldAll()
    normal gg

    let prev = line('.')
    normal ]]
    let cur = line('.')

    while (prev < cur)
        execute cur + 1
        if 0 != foldlevel('.')
            normal zd
        endif

        let prev = cur
        normal ]]
        let cur = line('.')

    endwhile
    normal gg
    echo "done"
endfunction

" Grep recusively in current directory for word under cursor
function MyGrep()
    let word=expand("<cword>")
    execute "grep -r '" . word . "' * "
    e#
    copen
endfunction

function MyViewChange()
    let myviews = system("cleartool lsview | grep kirpatil | sed -e 's,[^a-zA-Z]*kirpatil-\\([^\ ]*\\)\.*,\\1,'")
    let mychoice = confirm("Select a View", myviews, "Question")
    if mychoice != 0
        let viewname = system("cleartool lsview | grep kirpatil | sed -e 's,[^a-zA-Z]*\\([^\ ]*\\)\.*,\\1,' | head -" . mychoice . " | tail -1")
        execute "! cleartool setview " . viewname
    endif
endfunction


" c-0 to checkout current file
"nmap <> :! cc_co -de <C-R>=expand("%:p")<CR><CR>
"imap <> <esc>:! cc_co -de <C-R>=expand("%:p")<CR><CR>a

" c-9 to uncheckout current file
"nmap <c-9> :! cc_unco <C-R>=expand("%:p")<CR><CR>
"imap <c9> <esc>:! cc_unco <C-R>=expand("%:p")<CR><CR>a

" space to fold block
nmap <space> :call ToggleFold()<CR>

" c-3 to unc collapse all blocks
"nmap <c-3> :call FoldAll()<CR>
"nmap <c-4> :call UnFoldAll()<CR>

" grep recursively in current directory for word on the cursor
"map <c-5> :call MyGrep()<CR>

" source following to use :Man 
runtime ftplugin/man.vim

