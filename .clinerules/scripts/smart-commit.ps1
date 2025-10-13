# smart-commit.ps1
# This script automates the process of committing and pushing Markdown files in a Git repository.

# Open a PowerShell terminal session
$ErrorActionPreference = "Stop"

# Verify Git is installed
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git is not installed. Please install Git to proceed."
    exit 1
}

# Check the existence of the repository
if (-not (Test-Path .git)) {
    Write-Host "This is not a Git repository. Please navigate to a valid Git repository."
    exit 1
}

# Move to the repo root directory
cd (git rev-parse --show-toplevel)

# Ensure this is not the main branch but a valid branch
$currentBranch = git rev-parse --abbrev-ref HEAD
if ($currentBranch -eq "main" -or $currentBranch -eq "master") {
    Write-Host "You are on the '$currentBranch' branch. Please switch to a feature branch before committing."
    exit 1
}

# Look for only Markdown files and create an array with the names
$markdownFiles = Get-ChildItem -Recurse -Filter *.md | Select-Object -ExpandProperty FullName

if ($markdownFiles.Count -eq 0) {
    Write-Host "No Markdown files found to commit."
    exit 0
}

# Commit using the array
git add $markdownFiles
$commitMessage = "Update Markdown files: " + ($markdownFiles -join ", ")
git commit -m $commitMessage

# Push to the current branch
git push origin $currentBranch
Write-Host "Successfully pushed changes to the '$currentBranch' branch."
