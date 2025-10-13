# Workflow: my-envSetup

## Purpose
This workflow outlines the steps to create a Python virtual environment (.venv) and discusses the management of dependencies.

## Steps to Create a Virtual Environment

1. **Create the Virtual Environment**:
   - Open a PowerShell terminal.
   - Run the following command to create a virtual environment using the default Python:
     ```powershell
     python -3.11 -m venv .venv
     ```

2. **Activate the Virtual Environment**:
   - To activate the virtual environment, run:
     ```powershell
     .\.venv\Scripts\Activate.ps1
     ```

3. **Upgrade pip (Recommended)**:
   - After activation, it is recommended to upgrade pip:
     ```powershell
     python -m pip install --upgrade pip
     ```
