# shellcheck shell=bash

alias ll='ls -laGFT'
alias llmod='ll -t'

alias fuck='sudo $(history -p !!)'
alias fuckingplease='sudo "$BASH" -c "$(history -p !!)"'

alias cbws="code $WORK_REPOS/bws/."
alias cdbws="cd $WORK_REPOS/bws/"

alias crbs2="code $WORK_REPOS/bws2/."
alias cdrbs2="cd $WORK_REPOS/bws2/"

alias cfwp="code $WORK_REPOS/fwp/."
alias cdfwp="cd $WORK_REPOS/fwp/"

alias cfws='code $WORK_REPOS/fws/.'
alias cdfws="cd $WORK_REPOS/fws/"

alias cftach="code $WORK_REPOS/dc-ferguson-tachyons/."
alias cdftach="cd $WORK_REPOS/dc-ferguson-tachyons/"

alias cnode="code $WORK_REPOS/node-store/."
alias cdnode="cd $WORK_REPOS/node-store/"

alias cdot="code $DOTFILES/."
alias cddot="cd $DOTFILES/"

# Old repos
alias gbl="git branch --list"
alias glo="git log --oneline"
alias glg="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all
"
alias gs="git status"
alias gl="git log"
alias gc="git checkout"
alias gclean="git clean-branches"

# Usage: tree 3
alias tree='tree -LCF'

alias bashclean="env -i bash --norc --noprofile"

alias lsof-react="lsof -i :9000 -i :9001 -i :9002 -i :9003 -i :4000 -i :3000"
alias killnode="killall node"
alias killjava="killall java"

# alias xcode="open *.xcodeproj"

# alias python='python3'
# alias pip='pip3'

# alias server='python -m http.server 8080'

alias simulator='open -a Simulator.app'
alias startios='react-native run-ios --simulator="iPhone 16 Pro"'

alias typegen='npm run generate-types'
alias startns='fixnode; npm start -- --sites=build'
alias fixnode='test -f .nvmrc && nvm use'
alias disablehusky='git config --unset core.hooksPath'
alias enablehusky='git config core.hooksPath .husky'

alias cat='bat --paging=never'
function catcat() {
   /bin/cat "$@"
}
