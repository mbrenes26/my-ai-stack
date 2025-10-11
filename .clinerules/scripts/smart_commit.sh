#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   .clinerules/scripts/smart_commit.sh                 # auto message
#   .clinerules/scripts/smart_commit.sh "fix typos"     # custom message

DESC="${1:-}"  # optional custom description

# Ensure we are in a git repo
git rev-parse --git-dir >/dev/null 2>&1 || { echo "Not a git repo."; exit 1; }

# Stage changes if nothing staged
if [ -z "$(git diff --cached --name-only)" ]; then
  # Stage modified/deleted/new (but ignore .env, videos, etc., via .gitignore)
  git add -A
fi

# If still nothing to commit, bail
if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

# Collect staged files
FILES=$(git diff --cached --name-only)

# Decide a commit type from file patterns (very simple heuristic)
commit_type="chore"
if echo "$FILES" | grep -Ei '\.(py|ipynb|js|ts|sh|ps1|rb|go|java|scala|rs|cpp|c)$' >/dev/null; then
  commit_type="feat"
fi
if echo "$FILES" | grep -Ei '\.(md|rst|txt)$' >/dev/null; then
  commit_type="docs"
fi
if echo "$FILES" | grep -Ei '(^|/)\.github/|(^|/)\.clinerules/|(^|/)scripts/' >/dev/null; then
  commit_type="chore"
fi

# Create a short scope from top-level dirs touched
scope=$(echo "$FILES" \
  | awk -F/ '{print $1}' \
  | sed 's/^\.//g' \
  | awk 'NF' \
  | sort -u \
  | paste -sd, -)

[ -z "$scope" ] && scope="repo"

# Default description if none provided: summarize counts by extension
if [ -z "$DESC" ]; then
  count=$(echo "$FILES" | wc -l | awk '{print $1}')
  sample=$(echo "$FILES" | head -n 5 | paste -sd, -)
  DESC="update ${count} file(s): ${sample}"
fi

# Build final message: e.g., "docs(03_deep_learning): update 4 file(s): notes.md, ..."
msg="${commit_type}(${scope}): ${DESC}"

# Commit & push
git commit -m "$msg"
branch=$(git rev-parse --abbrev-ref HEAD)
git push -u origin "$branch"

echo "Committed and pushed:"
echo "  branch: $branch"
echo "  message: $msg"
