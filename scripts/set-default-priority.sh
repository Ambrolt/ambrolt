#!/usr/bin/env bash

set -euo pipefail

current=$(gh api repos/${REPO}/issues/${ISSUE_NUMBER}/issue-field-values \
  --jq '
    .[]
    | select(.issue_field_name=="Priority")
    | .single_select_option.name
  '
)

if [ -z "$current" ]; then
  echo "Setting default priority to 'Medium'"
  gh api "repos/${REPO}/issues/${ISSUE_NUMBER}/issue-field-values" \
    -X POST \
    --input - <<< '{
      "issue_field_values": [
        { "field_id": 46974467, "value": "Medium" }
      ]
    }'
else
  echo "Priority field already set to '$current', no action needed."
fi
