PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '

alias sshi="ssh -o StrictHostKeychecking=no -o UserKnownHostsFile=/dev/null"
alias scpi="scp -o StrictHostKeychecking=no -o UserKnownHostsFile=/dev/null"