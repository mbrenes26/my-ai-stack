# Workflow: git_auto_push

Purpose

* Automate the full Git workflow (stage, commit, and push) with a smart or custom commit message.
* Avoid manual typing in VS Code/Cline each time changes are made.

---

## Prerequisites

* `.clinerules/scripts/smart_commit.sh` must exist and be executable.
* The local repository must be initialized and linked to a remote (GitHub, Azure, etc.).
* A valid `.gitignore` exists to prevent unwanted files (.env, videos, etc.) from being committed.

---

## Trigger

In Cline chat or terminal:

```bash
/xdc_git_auto_push.md
```

or manually execute:

```bash
.clinerules/scripts/smart_commit.sh
```

---

## Example Usage

### 1) Default auto message

Automatically stages and commits changes with an auto-generated message based on file types and directories.

```bash
.clinerules/scripts/smart_commit.sh
```

Example output:

```
Committed and pushed:
  branch: dev
  message: docs(03_deep_learning): update 4 file(s): notes.md, diagrams/schema.png
```

### 2) Custom message

Provide your own message for clarity.

```bash
.clinerules/scripts/smart_commit.sh "refactor: clarify deep learning notes"
```

---

## Example Commit Message Formats

* `feat(03_deep_learning): add new convolution example`
* `docs(README): update table of contents`
* `fix(05_regression): correct formula for MSE`
* `chore(repo): reformat .gitignore and cleanup`

---

## Notes

* Uses Conventional Commit style automatically (`type(scope): description`).
* Safely stages only tracked or new files (respects .gitignore).
* Skips execution if no files have changed.
* Pushes automatically to the current branch (`main`, `dev`, etc.).

---

## Recommended Aliases

You can optionally add a short alias in your shell profile:

```bash
alias gpush=".clinerules/scripts/smart_commit.sh"
```

Then commit quickly with:

```bash
gpush "update deep learning summary"
