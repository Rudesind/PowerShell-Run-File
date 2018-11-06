## Start EXE
---
Script: Start_EXE.ps1
Updated: 6/14/2018
Author: Configuration Management
Version: 1.0

Script just starts the exe in the current directory. Other exes in the directory will cause the script to error.

#### Usage:
```
Start_EXE.ps1
```

#### Error Codes:
INITIALIZATION_FAILED (4000): Error occurred when initializing the variables.
LOG_LOAD_FAILED (4001): Error initializing the log file.
FAILED_TO_START_PROCESS (4003): Error starting exe, no exe, or too many exes
FAILED_TO_EXIT (4004): Could not properly exit the script.


### References:
---
[No Column Headings](https://stackoverflow.com/questions/1408042/output-data-with-no-column-headings-using-powershell)
[File Search](https://stackoverflow.com/questions/8677628/recursive-file-search-using-powershell)
