PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n↪ \$ '

alias sshi=ssh -o StrictHostKeychecking=no UserKnownHostsFile=/dev/null
alias scpi=scp -o StrictHostKeychecking=no UserKnownHostsFile=/dev/null
