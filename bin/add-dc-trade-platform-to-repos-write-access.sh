#!/bin/bash

ORG="FergDigitalCommerce"
if [[ -z "$1" ]]; then
  echo "Usage: $0 <team-slug>"
  exit 1
fi
TEAM_SLUG="$1"

REPOS_TO_IGNORE=(
  bwf-gha-runners-infra
  bwf-gha-fresh-repo-test
  bwf-gha-playground
  BWF-spring-email-service-gha-test
)

ALL_REPOS=$(gh api "orgs/${ORG}/repos" --paginate \
  --jq '[.[] | select(.name | test("gha-")) | .name] | .[]')

# Filter out ignored repos
REPOS=()
while IFS= read -r repo; do
  ignore=false
  for ignored in "${REPOS_TO_IGNORE[@]}"; do
    if [[ "$repo" == "$ignored" ]]; then
      ignore=true
      break
    fi
  done
  $ignore || REPOS+=("$repo")
done <<< "$ALL_REPOS"

echo "The following repos will receive write access for team '${TEAM_SLUG}':"
for REPO in "${REPOS[@]}"; do
  echo "  $REPO"
done
echo ""
echo "To exclude any repos, edit REPOS_TO_IGNORE in this script and re-run."
echo -n "Proceed? [y/N] "
read -r confirm
[[ "$confirm" == [yY] ]] || { echo "Aborted."; exit 0; }

echo ""
for REPO in "${REPOS[@]}"; do
  echo "Granting write to ${ORG}/${REPO} for team ${TEAM_SLUG}"
  gh api -X PUT "orgs/${ORG}/teams/${TEAM_SLUG}/repos/${ORG}/${REPO}" \
    -f permission=push | cat
done
