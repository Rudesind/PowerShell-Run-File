<#
    Script : Install_Package.ps1
    Updated: 11/9/2018
    Author : Zach Nybo <zach.nybo@gmail.com>
    Version: 1.0
    Documentation: Install_Package.md

    Summary:
    Installs a provided package with optional parameters. Configured to use 
    legacy logging at the moment.
#>

Param (

    [ValidateNotNullOrEmpty()] # Cannot be $null or ""
    [ValidateScript({(Test-Path $_)})] # File must exist
    [Parameter(Mandatory=$True)] # Mandatory and Pipeline allowed
    [string] $Path,

    [ValidateNotNullOrEmpty()] # Cannot be $null or ""
    [Parameter(Mandatory=$True)] # Mandatory and Pipeline allowed
    [string] $File,

    [ValidateNotNullOrEmpty()] # Cannot be $null or ""
    [Parameter(Mandatory=$True)] # Mandatory and Pipeline allowed
    [string] $Arg # Optional Parameter for the arguments

)

# Script Information
#
New-Variable SCRIPT -option Constant -value "Install_Package"
New-Variable AUTHOR -option Constant -value "Zach Nybo"
New-Variable UPDATED -option Constant -value "11/9/2018"
New-Variable VERSION -option Constant -value "1.0"

# Error Codes
#
New-Variable MODULE_LOAD_FAILED -option Constant -value 4000
New-Variable INITIALIZATION_FAILED -option Constant -value 4002
New-Variable LOG_LOAD_FAILED -option Constant -value 4003
New-Variable INSTALL_FAILED -option Constant -value 4004
New-Variable FAILED_TO_EXIT -option Constant -value 4010

# Initialize Variables
#
try {

    # Friendly error message
    #
    $errorMsg = [string]::Empty
    
    # The install process object
    #
    $process = $null

    # Process exit code
    #
    $exitCode = 0

} catch {
    $errorMsg = "Error, could not Initialize script: " + $Error[0]
    exit $INITIALIZATION_FAILED
}

# Load Modules
#
try {

    # LOG module is used for logging
    #
    Import-Module ".\LOG_Legacy.psm1"

} catch {
    exit $MODULE_LOAD_FAILED
}

# Initialize Log file
#
try {

    Initialize-Log -Path ".\" -Name "$SCRIPT-$File"
    
    # Write the script info to the log
    #
    Write-Log "---"
    Write-Log $SCRIPT
    Write-Log $UPDATED
    Write-Log $AUTHOR
    Write-Log $VERSION
    Write-Log "---"

} catch {
    $errorMsg = "Error, could not initialize log: " + $Error[0]
    exit $LOG_LOAD_FAILED
}

# Install the application
#
try {

    # Ensure the file exists
    #
    Write-Log "Checking if $File exists..."
    if (!(Test-Path "$Path\$File")) {

        # File was not found
        # 
        throw "File Not Found"

    }

    Write-Log "File found at $Path"

    # Launch the file and wait to finish
    #
    Write-Log "Starting $File with $Arg as parameters..."
    $process = Start-Process -FilePath "$Path\$File" -ArgumentList $Arg -Wait
    
    #TODO: This exit code isn't being collected correctly
    $exitCode = $process.ExitCode
    
    # Check error code returned by Start-Process
    #
    Write-Log "Process completed with error code: $exitCode"

} catch {
    $errorMsg = "Error, processing of $File failed to complete: " + $Error[0]
    Write-Log $errorMsg
    Write-Log "Exiting with error code: $INSTALL_FAILED"
    exit $INSTALL_FAILED
}

try {

    Write-Log "Exiting script with error code: 0"
    exit 0

} catch {
    $errorMsg = "Error, could not exit: " + $Error[0]
    Write-Log $errorMsg
    Write-Log "Exiting with error code: $FAILED_TO_EXIT"
    exit $FAILED_TO_EXIT
}


