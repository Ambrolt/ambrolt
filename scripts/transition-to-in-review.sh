#!/usr/bin/env bash

set -euo pipefail

if   [ "$MERGED" = "true" ]; then exit 0  # merged: skip
elif [ "$ACTION" = "closed" ]; then status="In progress"
elif [ "$DRAFT" = "true" ]; then status="In progress"
else status="In review"; fi

if [[ $BRANCH =~ ^gh-([0-9]+)/ ]]; then
  issue_number="${BASH_REMATCH[1]}"
else
  echo "Branch '$BRANCH' has no gh-##/ prefix, skipping."
  exit 0
fi

echo "Transitioning issue #$issue_number to '$status'"

gh project item-edit 1 --owner Ambrolt \
  --url "https://github.com/${REPO}/issues/${issue_number}" \
  --field Status --value "$status"
