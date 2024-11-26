# shellcheck shell=bash

alias ll='ls -laGFT'
alias llmod='ll -t'

alias fuck='sudo $(history -p !!)'
alias fuckingplease='sudo "$BASH" -c "$(history -p !!)"'

alias crbs="code $REPOSITORIES/bwf-web-store/."
alias cdrbs="cd $REPOSITORIES/bwf-web-store/"

alias crbs2="code $REPOSITORIES/bwf-web-store2/."
alias cdrbs2="cd $REPOSITORIES/bwf-web-store2/"

alias cfwp="code $REPOSITORIES/bwf-web-platform/."
alias cdfwp="cd $REPOSITORIES/bwf-web-platform/"

alias cfws='code $REPOSITORIES/dc-ferg-web-store/.'
alias cdfws="cd $REPOSITORIES/dc-ferg-web-store/"

alias cftach="code $REPOSITORIES/dc-ferguson-tachyons/."
alias cdftach="cd $REPOSITORIES/dc-ferguson-tachyons/"

alias cnode="code $REPOSITORIES/BWF-node-store/."
alias cdnode="cd $REPOSITORIES/BWF-node-store/"

alias cdot="code $DOTFILES/."
alias cddot="cd $DOTFILES/"

# Old repos
alias crbsold="code $REPOSITORIES/react-build-store/."
alias cdrbsold="cd $REPOSITORIES/react-build-store/"

alias crbs2old="code $REPOSITORIES/react-build-store-alt/."
alias cdrbs2old="cd $REPOSITORIES/react-build-store-alt/"

alias cnodeold="code $REPOSITORIES/node-store/."
alias cdnodeold="cd $REPOSITORIES/node-store/"

alias cfwpold="code $REPOSITORIES/fergy-web-platform/."
alias cdfwpold="cd $REPOSITORIES/fergy-web-platform/"

alias crfsold="code $REPOSITORIES/react-ferg-store/."
alias cdrfsold="cd $REPOSITORIES/react-ferg-store/"

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
alias startios='react-native run-ios --simulator="iPhone 8 Plus"'

alias typegen='npm run generate-types'
alias startns='fixnode; npm start -- --sites=build'
alias fixnode='test -f .nvmrc && nvm use'
alias disablehusky='git config --unset core.hooksPath'
alias enablehusky='git config core.hooksPath .husky'

alias cat='bat --paging=never'