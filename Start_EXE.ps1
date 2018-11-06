
#-----------------------------------#
# Script : Start_EXE.ps1
# Updated: 6/14/2018
# Author : Configuration Management
# Version: 1.0
# Documentation: Start_EXE_README.md
#
# Summary:
# This script starts a single exe in
# the same directory.
#-----------------------------------#

#--------------------#
# Script Information #
#--------------------#

New-Variable SCRIPT -option Constant -value "Start_EXE.ps1"
New-Variable AUTHOR -option Constant -value "Configuration Management"
New-Variable UPDATED -option Constant -value "6/14/2018"
New-Variable VERSION -option Constant -value "1.0"

#-------------#
# Error Codes #
#-------------#

New-Variable INITIALIZATION_FAILED -option Constant -value 4000
New-Variable LOG_LOAD_FAILED -option Constant -value 4001
New-Variable FAILED_TO_START_PROCESS -option Constant -value 4003
New-Variable FAILED_TO_EXIT -option Constant -value 4004

#--------------#
# Log Function #
#--------------#

# Idea taken from:
# https://stackoverflow.com/questions/7834656/create-log-file-in-powershell
# The below function is used to write to a log file
Function LogWrite {

    # Parameters for the function
    # $logsting is the string written to the file
    Param ([string]$logstring)

    # The current time stamp for the log entry. Updated with every write
    $time = Get-Date -Format g

    # Write the contents to a log file at the specified location
    Add-content $logFile -value "$time $logstring" -ErrorAction Stop

}

#----------------------#
# Initialize Variables #
#----------------------#

try {

    # Friendly error message
    $errorMsg = ""

    # Time stamp is in ISO 8601 standard
    $timestamp = Get-Date -format "yyyyMMddTHHmmss"

    # Log file directory
    $logDir = "C:\URM"

    # Log file path
    $logFile = "$logDir\Start_EXE_$timestamp.txt"

} catch {
    $errorMsg = "Error, could not Initialize script: " + $Error[0]
    exit $INITIALIZATION_FAILED
}

#---------------------#
# Initialize Log file #
#---------------------#

try {

    LogWrite "---"
    LogWrite $SCRIPT
    LogWrite $UPDATED
    LogWrite $AUTHOR
    LogWrite $VERSION
    LogWrite "---"

} catch {
    $errorMsg = "Error, could not load log file: " + $Error[0]
    exit $LOG_LOAD_FAILED
}

#-----------#
# Start EXE #
#-----------#

try {

    LogWrite "Getting file name..."
    $EXE = Get-ChildItem -Path $PWD -Filter *.exe | Foreach {$_.Name}

    LogWrite "Done"

    LogWrite "Starting $EXE..."
    Start-Process $EXE

    LogWrite "Done"

} catch {
    $errorMsg = "Error, could not start or locate EXE: " + $Error[0]
    LogWrite $errorMsg
    LogWrite "Exiting with error code: $FAILED_TO_START_PROCESS"
    exit $FAILED_TO_START_PROCESS
}

#------#
# Exit #
#------#

try {

    # Exit
    $code = "0"
    LogWrite "Exiting script with error code: $code"

} catch {
    $errorMsg = "Error, code not exit: " + $Error[0]
    LogWrite $errorMsg
    LogWrite "Exiting with error code: $FAILED_TO_EXIT"
    exit $FAILED_TO_EXIT
}
