#!/bin/bash

ORG="FergDigitalCommerce"
TEAM_SLUG="dc-trade-platform"

REPOS=(
  "fh-gha-commit-cop"
  "bwf-gha-template-repo"
  "bwf-gha-jira-labeler"
  "bwf-gha-playground"
  "bwf-gha-get-outputs"
  "bwf-gha-pr-labeler"
  "bwf-gha-create-jira"
  "bwf-gha-transition-jira"
  "bwf-gha-check-circular-dependencies"
  "fh-gha-parse-commits"
  "gha-file-sync"
)

for REPO in "${REPOS[@]}"; do
  echo "Granting write to ${ORG}/${REPO} for team ${TEAM_SLUG}"
  gh api -X PUT "orgs/${ORG}/teams/${TEAM_SLUG}/repos/${ORG}/${REPO}" \
    -f permission=push | cat
done

gh api "orgs/FergDigitalCommerce/teams/dc-trade-platform/repos" --paginate \
  --jq '.[] | {repo: .full_name, admin: .permissions.admin, push: .permissions.push, pull: .permissions.pull}'
