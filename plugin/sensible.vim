" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.2

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 'yes'
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

" 在normal模式下，光标停留在数字时，按ctrl + a使数字加1，按ctrl + x使数字减1
" 在加减1时，以十进制计算
set nrformats-=octal

" 两次按下按键时的时间间隔设置
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" 在输入搜索内容时就显示搜索结果
set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

 
" 总是显示状态栏
set laststatus=2
" 显示光标所在的列数和行数
set ruler
" 在命令行输入区域，输入某个关键字，按tab键，自动显示关键字相关的命令 
set wildmenu
" 如果开启了scrolloff，在光标滚动到距离最顶端或最底部只剩1行时就滚动显示更多。
if !&scrolloff
  set scrolloff=1
endif
" 如果开启了sidescrolloff，在光标滚动到距离最左边或最右边只剩5个字符时就滚动显示更多。
if !&sidescrolloff
  set sidescrolloff=5
endif
" 对于不能一行显示完整的长文本，不要显示全部，一行能显示多少就显示多少
set display+=lastline

" 使用UTF-8编码显示文本内容，更好的显示中文文本
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" 设置不可见字符的显示替换字符
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" 在多行合并成一行时，对于注释文本，自动去掉注释符号
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" 设置tags目录
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" 设置shell环境
if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
  set shell=/usr/bin/env\ bash
endif

" 自动加载外部修改
set autoread

" 设置Vim操作历史数为1000
if &history < 1000
  set history=1000
endif

" 设置最多有50个标签页
if &tabpagemax < 50
  set tabpagemax=50
endif

" 保存全局变量，! 以大写字母开头的全局变数，并且不含有小写字母
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
" matchit.vim是系统默认自带的，但不安装，可以通过`:help matchit-install`查看安装说明
" matchit.vim是一个支持光标在语法关键词中跳转的插件。如光标在begin上，按`%`会跳转到end。
" 设置关键词匹配跳转
" let b:match_word='\<begin\>:\<end\>,'
"     \ . '\<while\>:\<continue\>:<break\>:\<endwhile\>,'
"     \ . '\<if\>:\<else if\>:<else\>,'
"     \ . '\<module\>:\<endmodule\>,'
"     \ . '\<task\>:\<endtask\>,'
"     \ . '\<function\>:\<endfunction\>,'
"     \ . '\<program\>:\<endprogram\>'
" 开启并忽略大小写
" let b:matchit_ignorecase=1
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
" 插入模式下，按ctrl + u撤销
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
" 插入模式下，按ctrl + w删除一个单词
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" vim:set ft=vim et sw=2:
