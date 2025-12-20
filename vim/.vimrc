set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set listchars=eol:↩
set list
set mouse=a
set number
set relativenumber
:filetype plugin on
set belloff=all
set smartindent

if executable('rg')
  set grepprg=rg\ --vimgrep\ --hidden\ --glob\ '!.git'
endif

