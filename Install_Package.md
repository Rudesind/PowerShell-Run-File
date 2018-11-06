# Install Package

---
Module: Install_Package.ps1
Updated: 10/22/2018
Author: Configuration Management
Version: 1.0

This script launches the provided file with arguments and returns the error code.

This script requires the use of `LOG.psm1`.

## Syntax

```powershell
Install_Package.ps1 <file_path> <file> <arguments>
```

## Error Codes

(-1): The script could not be initialized.
MODULE_LOAD_FAILED (4000): Could not load the needed modules.
INITIALIZATION_FAILED (4002): Could not initialize needed variables.
LOG_LOAD_FAILED (4003): Failed to initialize the log file.
INSTALL_FAILED (4004): Failed to run\install the provided file.
FAILED_TO_EXIT (4010): Failed to exit properly.