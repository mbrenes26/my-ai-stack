# Workflow: my-smart-gitpush

## Purpose
This workflow automates the process of committing and pushing Markdown files in a Git repository using the `smart-commit.ps1` script.

## How YOU run it (operator perspective)

1. **Run the PowerShell 7 script**:
   - Open a PowerShell 7 terminal.
   - Execute the script by running:
     ```pwsh.exe -File .\.clinerules\scripts\smart-commit.ps1
     ```

2. **Ensure you are in a valid Git repository**:
   - Navigate to the root directory of your Git repository. Run $pwd and look for the .git folder:
   ```powershell
   $pwd
   ls -la
   # If .git folder is listed, run:
   pwsh.exe -File .\.clinerules\scripts\smart-commit.ps1
   ```

3. **Follow the script prompts**:
   - The script will verify that Git is installed and check if you are on a valid branch.
   - It will look for Markdown files and commit them with a generated message.

4. **Completion**:
   - The script will push the changes to the current branch and confirm the successful operation.

## Notes
- Ensure that you have the necessary permissions to push changes to the repository.
- The script will only commit Markdown files found in the repository.
- If you are on the main or master branch, the script will exit without making any changes.
