#!/usr/bin/env bash
set -euo pipefail

# smart_commit.sh
# -----------------
# Stages changes, generates or uses a provided commit message,
# pushes to the current branch, and opens/updates a Pull Request.
#
# Usage:
#   .clinerules/scripts/smart_commit.sh                 # auto message
#   .clinerules/scripts/smart_commit.sh "fix typos"     # custom message
#
# Notes:
# - Supports GitHub via `gh` CLI if available; falls back to REST API if GITHUB_TOKEN is set.
# - Determines base branch from remote HEAD (e.g., main or master).
# - Respects your .gitignore; will not commit ignored files.

DESC="${1:-}"

# Ensure we are in a git repo
if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a git repository." >&2
  exit 1
fi

# Stage changes if nothing staged yet
if [ -z "$(git diff --cached --name-only)" ]; then
  git add -A
fi

# If still nothing staged, exit quietly
if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

# Collect staged files
FILES=$(git diff --cached --name-only)

# Heuristic: choose commit type from staged files
commit_type="chore"
if echo "$FILES" | grep -Eqi '\\.(py|ipynb|js|ts|sh|ps1|rb|go|java|scala|rs|cpp|c)$'; then
  commit_type="feat"
fi
if echo "$FILES" | grep -Eqi '\\.(md|rst|txt)$'; then
  commit_type="docs"
fi
if echo "$FILES" | grep -Eqi '(^|/)\.github/|(^|/)\.clinerules/|(^|/)scripts/'; then
  commit_type="chore"
fi

# Scope from top-level dirs
scope=$(echo "$FILES" | awk -F/ '{print $1}' | sed 's/^\.//g' | awk 'NF' | sort -u | paste -sd, -)
[ -z "$scope" ] && scope="repo"

# Default description if none provided
if [ -z "$DESC" ]; then
  count=$(echo "$FILES" | wc -l | awk '{print $1}')
  sample=$(echo "$FILES" | head -n 8 | paste -sd, -)
  DESC="update ${count} file(s): ${sample}"
fi

msg="${commit_type}(${scope}): ${DESC}"

# Commit & push
git commit -m "$msg"
branch=$(git rev-parse --abbrev-ref HEAD)
# Discover default base from remote HEAD (e.g., origin/main)
remote_head_ref=$(git symbolic-ref -q --short refs/remotes/origin/HEAD || true)
base=${remote_head_ref#origin/}
[ -z "$base" ] && base="main"  # fallback

echo "Pushing branch '$branch' to origin..."
git push -u origin "$branch"

# Determine hosting provider
origin_url=$(git remote get-url origin)

create_pr_with_gh() {
  # Requires GitHub CLI and authenticated session
  echo "Creating/updating PR with GitHub CLI..."
  # If a PR already exists from branch -> base, `gh pr create` will fail; handle gracefully
  if gh pr view "$branch" --base "$base" >/dev/null 2>&1; then
    url=$(gh pr view "$branch" --json url -q .url)
    echo "PR already exists: $url"
  else
    body=$(printf "Automated commit from smart_commit.sh\n\nCommit message:\n%s\n\nFiles:\n%s\n" "$msg" "$FILES")
    gh pr create --title "$msg" --body "$body" --base "$base" --head "$branch"
    url=$(gh pr view "$branch" --json url -q .url)
    echo "PR created: $url"
  fi
}

create_pr_with_api() {
  # Use GitHub REST API via GITHUB_TOKEN
  echo "Creating PR via GitHub REST API..."
  # Parse owner/repo from origin URL
  # Handles forms like:
  #  - https://github.com/OWNER/REPO.git
  #  - git@github.com:OWNER/REPO.git
  repo_path=$(echo "$origin_url" | sed -E 's#(git@|https://)github.com[:/ ]##; s#\.git$##')
  owner=$(echo "$repo_path" | cut -d'/' -f1)
  repo=$(echo "$repo_path" | cut -d'/' -f2)
  api="https://api.github.com/repos/${owner}/${repo}/pulls"
  body_json=$(jq -nc --arg title "$msg" --arg head "$branch" --arg base "$base" --arg body "Automated PR from smart_commit.sh\n\n$FILES" '{title:$title, head:$head, base:$base, body:$body}')
  resp=$(curl -sS -X POST "$api" \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    -d "$body_json")
  pr_url=$(echo "$resp" | jq -r '.html_url // empty')
  if [ -n "$pr_url" ]; then
    echo "PR created: $pr_url"
  else
    echo "Failed to create PR via API. Response:" >&2
    echo "$resp" >&2
    exit 1
  fi
}

maybe_create_pr=false
if echo "$origin_url" | grep -qi 'github.com'; then
  maybe_create_pr=true
fi

if [ "$maybe_create_pr" = true ]; then
  # Prefer gh; fallback to REST if token present
  if command -v gh >/dev/null 2>&1; then
    create_pr_with_gh || true
  elif [ -n "${GITHUB_TOKEN:-}" ]; then
    # Require jq for JSON encoding
    if ! command -v jq >/dev/null 2>&1; then
      echo "jq is required to build the PR request body. Please install jq or use gh CLI." >&2
      exit 1
    fi
    create_pr_with_api || true
  else
    echo "Skipping PR creation: neither gh CLI is available nor GITHUB_TOKEN is set."
  fi
else
  echo "Origin is not GitHub, skipping PR creation."
fi

echo "Done."
