# Powershell-Run-File

---

`Install_Package.ps1` launches the provided file with arguments and returns the error code.

This script requires the use of `LOG.psm1`.

`Start_EXE.ps` starts the exe in the current directory. Other exes in the directory will cause the script to error.

## Syntax

```powershell
Install_Package.ps1 <file_path> <file> <arguments>
```

```powershell
Start_EXE.ps1
```

## Error Codes

### Install_Package.ps1

(-1): The script could not be initialized.
MODULE_LOAD_FAILED (4000): Could not load the needed modules.
INITIALIZATION_FAILED (4002): Could not initialize needed variables.
LOG_LOAD_FAILED (4003): Failed to initialize the log file.
INSTALL_FAILED (4004): Failed to run\install the provided file.
FAILED_TO_EXIT (4010): Failed to exit properly.

### Start_EXE.ps1

INITIALIZATION_FAILED (4000): Error occurred when initializing the variables.
LOG_LOAD_FAILED (4001): Error initializing the log file.
FAILED_TO_START_PROCESS (4003): Error starting exe, no exe, or too many exes
FAILED_TO_EXIT (4004): Could not properly exit the script.

### References

---

[No Column Headings](https://stackoverflow.com/questions/1408042/output-data-with-no-column-headings-using-powershell)
[File Search](https://stackoverflow.com/questions/8677628/recursive-file-search-using-powershell)
