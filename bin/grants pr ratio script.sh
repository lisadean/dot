#!/bin/bash

# You'll notice for received PRs, I'm stripping out reviews that have a state of
# "commented" and an empty body. This is in aim to not count each thread comment as
# a new received review, but continue to count a review that's only a "comment"
# (Not an Approval or Request Changes)
ORG="FergDigitalCommerce"
SINCE=$(date -v-3m +%Y-%m-%d)

ME=$(gh api user --jq '.login')

echo "Calculating reviews received..."
RECEIVED=$(gh search prs \
  --author @me \
  --owner "$ORG" \
  --updated ">$SINCE" \
  --json number,repository \
  --limit 200 \
| jq -r '.[] | "\(.repository.nameWithOwner) \(.number)"' \
| while read repo number; do
    gh api "repos/$repo/pulls/$number/reviews" --jq "[.[] | select(.submitted_at >= \"$SINCE\" and (.user.login | test(\"\\\\[bot\\\\]\") | not) and (.state == \"APPROVED\" or .state == \"CHANGES_REQUESTED\" or (.state == \"COMMENTED\" and .body != \"\")))] | length"
  done \
| jq -s 'add')

echo "Calculating reviews given..."
GIVEN=$(gh search prs \
  --reviewed-by @me \
  --owner "$ORG" \
  --updated ">$SINCE" \
  --json number,repository \
  --limit 200 \
| jq -r '.[] | "\(.repository.nameWithOwner) \(.number)"' \
| while read repo number; do
    gh api "repos/$repo/pulls/$number/reviews" --jq "[.[] | select(.user.login == \"$ME\" and .submitted_at >= \"$SINCE\" and (.state == \"APPROVED\" or .state == \"CHANGES_REQUESTED\" or (.state == \"COMMENTED\" and .body != \"\")))] | length"
  done \
| jq -s 'add')

echo ""
echo "Reviews given:    $GIVEN"
echo "Reviews received: $RECEIVED"
echo "$GIVEN $RECEIVED" | awk '{printf "Ratio (given/received): %.2f\n", $1/$2}'
