# shellcheck shell=bash

# git checkout branch
function gcb {
  branchName=$1

  git show-ref --verify --quiet refs/heads/${branchName}
  exists=$? # $? == 0 means local branch already exists

  if [ ${exists} -eq 0 ]; then
    echo "Checking out existing branch ${branchName}"
    git checkout ${branchName}
  else
    echo "Creating new branch ${branchName}"
    git checkout -b ${branchName}
  fi
}
export -f gcb

function gcbs {
  issueNumber=$1
  issuePrefix='HMW-'
  branchName="${issuePrefix}${issueNumber}"
  gcb ${branchName}
}
export -f gcbs

# git checkout remote branch
function gcrb {
  branchName=$1
  git checkout -b ${branchName} origin/${branchName}
}
export gcrb

function gcrbs {
  issueNumber=$1
  issuePrefix='HMW-'
  branchName="${issuePrefix}${issueNumber}"
  gcrb ${branchName}
}

# git branch delete
function gbd {
  branchName=$1
  echo "Deleting branch ${branchName}"
  git branch -d ${branchName}
  echo
  echo Branches:
  git branch --list
}
export -f gbd

function gbds {
  issueNumber=$1
  issuePrefix='SODEV-'
  branchName="${issuePrefix}${issueNumber}"
  gbd ${branchName}
}
export -f gbds

# git push
function gp {
  # Set upstream for new branch if needed and do a git push. Don't push to master

  branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null)"
  upstream="$(git rev-parse --abbrev-ref ${branchName}@{upstream} 2> /dev/null)"

  function doPush() {
    if [ -z "${upstream}" ]; then
      echo "New branch. Setting remote for ${branchName} and pushing to remote"
      git push --set-upstream origin ${branchName}
    else
      echo "Existing upstream. Pushing to ${branchName} remote"
      git push
    fi
    return
  }

  if [ "${branchName}" == "master" ] || [ "${branchName}" == "main" ]; then
    RED='\033[0;31m'
    RESET='\033[m'
    echo -e "☠️   ☠️   ${RED}You are pushing to master. Are you sure?${RESET}   ☠️   ☠️"
    echo
    echo -e "Choose a selection by using the number of the selection:"
    select yn in "Yes" "No"
    do
      case $yn in
        Yes ) doPush; break;;
        No ) echo -e "Bailing on push"; break;;
      esac
    done
  else
    doPush
  fi

  return
}
export -f gp

function ld() { builtin cd "$@" && ls -laGFT; }
export -f ld

# # This is for working with my dotfiles repo
# # alias config='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
# # alias cgs='config status'
# # alias cgs-untracked='config status -unormal'
# function git() {
#     if [[ "$PWD" == "$HOME" ]]; then
#       # echo "I'm home"
#       # config "$@"
#       /usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME "$@"
#     else
#       # echo "I'm not home"
#       command git "$@"
#     fi
# }

function gd() {
  GIT_USER_NAME='Lisa Dean'
  GIT_USER_EMAIL='lisa@lisadean.net'
  GIT_USER_EMAIL_FERG='lisa.dean@supply.com'
  builtin cd "$@"
  if [[ "$PWD" == "$REPOSITORIES" || "$PWD" == "$HOME" ]]; then
    git config user.name "$GIT_USER_NAME"
    git config user.email "$GIT_USER_EMAIL"
  elif [[ "$PWD" == "$REPOSITORIES/ferg" ]]; then
    git config user.name "$GIT_USER_NAME"
    git config user.email "$GIT_USER_EMAIL_FERG"
  fi
  echo "Changed git user.email: $(git config user.email)"
}
export -f gd