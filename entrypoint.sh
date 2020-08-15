#!/bin/sh

BODY="$(jq '.comment.body' $GITHUB_EVENT_PATH)"
ISSUE_NUMBER="$(jq '.issue.number' $GITHUB_EVENT_PATH)"
LOGIN="$(jq '.comment.user.login' $GITHUB_EVENT_PATH)"
REPO="$(jq '.repository.full_name' $GITHUB_EVENT_PATH)"

if [[ "$BODY" == *".take"* ]]; then
  echo "Assigning issue $ISSUE_NUMBER to $LOGIN"
  curl -H "Authorization: token $GITHUB_TOKEN" -d "{'assignees':
  [$LOGIN]}" https://api.github.com/repos/$REPO/issues/$ISSUE_NUMBER/assignees
fi
