call plug#begin('~/.config/nvim/plugged')

" 模糊搜索文件
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 主题
Plug 'connorholyday/vim-snazzy'
" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" 查找内容
Plug 'brooth/far.vim'
" 启动页
Plug 'mhinz/vim-startify'
" 文件目录
Plug 'preservim/nerdtree'
" 主题
Plug 'theniceboy/nvim-deus'

" Treesitter 参数高亮
Plug 'nvim-treesitter/nvim-treesitter'
" Flutter
Plug 'dart-lang/dart-vim-plugin'

" FLutter
Plug 'thosakwe/vim-flutter'

" Status line
Plug 'theniceboy/eleline.vim'
Plug 'ojroques/vim-scrollstatus'

" 回车选中word
Plug 'gcmt/wildfire.vim'
" cs"'  替换“‘，VS} 用括号引住
Plug 'tpope/vim-surround'

" 多光标
" select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
" create cursors vertically with Ctrl-Down/Ctrl-Up
" select one character at a time with Shift-Arrows
" press n/N to get next/previous occurrence
" press [/] to select next/previous cursor
" press q to skip current and get next occurrence
" press Q to remove current cursor/selection
" start insert mode with i,a,I,A
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"



call plug#end()

" 高亮
syntax on
" 行号
set number
" 相对行号
set relativenumber
" 设置行线
set cursorline
" 自动换行
set wrap
" 显示按键
set showcmd
" tab 不全   :命令
set wildmenu
" 搜索高亮 打开另个文件不搜索
set hlsearch
exec "nohlsearch"
" 搜索边输边高亮
set incsearch
" 搜搜忽略大小写
set ignorecase
" 智能小写
set smartcase
" 设置snazzy主题
colorscheme snazzy
" snazzy主题
"let g:SnazzyTransparent = 1
" 差异
set nocompatible
" 识别不同的文件格式
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
" 使用鼠标
set mouse=a
set encoding=utf-8
" 配色问题兼容
let &t_ut=""
" tab缩进
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" 显示不可见字符 空格
set list
set listchars=tab:►\ ,trail:▹
" 你可能更喜欢将光标放在中间的位置而不是第一行,设置下面的选项可以将光标位置设置为第 5 行。上下溢出
set scrolloff=5
" 在行首使用删除键盘 到上行行尾
set backspace=indent,eol,start
" 收起代码
set foldlevel=99
" 
set autochdir


" vim 与系统共享 剪切板
set clipboard=unnamedplus


" LEADER
let mapleader=" "


" ==================================================
" ============================================Far
" ==================================================
"空格 两次 f
nnoremap <silent> <LEADER>f :F  %<left><left>
noremap <LEADER>f :F  **/*<left><left><left><left><left>

" ==================================================
" ============================================nerdtree
" ==================================================
" nnoremap  tt :NERDTreeToggle <CR> 



" ==================================================
" ============================================Cocvim
" ==================================================
let g:coc_global_extensions = ['coc-marketplace', 'coc-json', 'coc-flutter', 'coc-flutter-tools', 'coc-syntax', 'coc-snippets', 'coc-sourcekit', 'coc-actions', 'coc-diagnostic', 'coc-explorer', 'coc-eslint', 'coc-translator', 'coc-xml']


set hidden
" 提示刷新时间
set updatetime=100
" 信息栏少打印东西
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" option + o  补全
inoremap <silent><expr> ø coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" 查看代码报错
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" 代码跳转
" 跳转到定义的地方
nmap <silent> gd <Plug>(coc-definition)
" 
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 查看函数定义
nnoremap <silent> <LEADER>s :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" 光标移动到单词上，其他一样的单词也显示
autocmd CursorHold * silent call CocActionAsync('highlight')

" 修改变量名字
nmap <leader>rn <Plug>(coc-rename)

" 代码格式化
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

" 
xmap <leader>a  <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a  <Plug>(coc-codeaction-selected)<CR>



" ==================================================
" ============================================操作区
" ==================================================

" normal no recursive map  <CR>表示回车
nnoremap -f :Files<CR>

" 空格回车 删除搜索高亮
noremap <LEADER><CR> :nohlsearch<CR>

" 小写s nop
map s <nop>
" 大写S，表示保存文件
map S :w<CR>
" 大写Q，退出文件
map Q :q<CR>
" 重新加载文件
map R :source $MYVIMRC<CR>


" 分屏操作
" 向右分屏
map sl :set splitright<CR>:vsplit<CR>
" 向左分屏
map sh :set nosplitright<CR>:vsplit<CR>
" 向上分屏
map sk :set nosplitbelow<CR>:split<CR>
" 向下分屏
map sj :set splitbelow<CR>:split<CR>

" 分屏移动指针
map <LEADER>l <C-w>l
map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k

" 分屏控制窗口大小
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" sv sh 是横向分屏 改垂直分屏
map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K

" 标签
map tn :tabe<CR>
" 右标签
map tl :+tabnext<CR>
" 左标签
map th :-tabnext<CR>


nnoremap <LEADER>r :CocCommand translator.popup<CR>
nnoremap tt :CocCommand explorer<CR>

" ===
" === nvim-treesitter
" ===
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"typescript", "dart", "java"},     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

" ===
" === dart-vim-plugin
" ===
let g:dart_style_guide = 2
let g:dart_format_on_save = 1
let g:dartfmt_options = ["-l 100"]

"set termguicolors " enable true colors support

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 color deus
 hi NonText ctermfg=gray guifg=grey10

 let g:terminal_color_0  = '#000000'
 let g:terminal_color_1  = '#FF5555'
 let g:terminal_color_2  = '#50FA7B'
 let g:terminal_color_3  = '#F1FA8C'
 let g:terminal_color_4  = '#BD93F9'
 let g:terminal_color_5  = '#FF79C6'
 let g:terminal_color_6  = '#8BE9FD'
 let g:terminal_color_7  = '#BFBFBF'
 let g:terminal_color_8  = '#4D4D4D'
 let g:terminal_color_9  = '#FF6E67'
 let g:terminal_color_10 = '#5AF78E'
 let g:terminal_color_11 = '#F4F99D'
 let g:terminal_color_12 = '#CAA9FA'
 let g:terminal_color_13 = '#FF92D0'
 let g:terminal_color_14 = '#9AEDFE'


let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'rxroc'




