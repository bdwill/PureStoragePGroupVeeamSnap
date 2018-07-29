<#
.SYNOPSIS
A PowerShell script to create a FlashArray snapshot of volumes that reside in a target Protection Group by Veeam Backup and Replication.

.DESCRIPTION
A PowerShell script that enables Veeam Backup and Replication to create snapshots of all volumes in a FlashArray Protection Group.
Targeted use case is running this script on a user-defined basis in Windows Task Scheduler.

.EXAMPLE
(In Windows Task Scheduler)
PowerShell.exe c:\PATH\PureStoragePGroupVeeamSnap.ps1

License
--------
MIT License

Copyright (c) 2018 Brandon Willmott

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

# Load Veeam PowerShell SnapIn
Add-PSSnapin VeeamPSSnapIn -ErrorAction SilentlyContinue

<# Use Encrypted Credentials
*** If not done already, execute the following in a PowerShell command prompt ***
Read-Host -AsSecureString  | ConvertFrom-SecureString | Out-File "c:\temp\Secure-Credentials.txt"
#>

# *** SET THE FOLLOWING VARIABLES BFORE USE ***
$flasharray = "flasharray.purestorage.com" #IP/FQDN
$PfaProtectionGroup = "pg-production-vms" #Name of the protection group you want to take snapshots of
$PasswordFile = “c:\temp\Secure-Credentials.txt”

# Connect to Pure Storage FlashArray
$pwd = get-content $PasswordFile | ConvertTo-SecureString
$creds = New-Object System.Management.Automation.PSCredential ("pureuser",$pwd)
$array = New-PfaArray -Endpoint $flasharray -Credentials $creds -IgnoreCertificateError

# Load the FlashArray from Veeam
$storage = Get-StoragePluginHost -name $array

# Get the Protection Group from the FlashArray
$pg = Get-PfaProtectionGroup -array $array -name $PfaProtectionGroup

# Create a list of the volumes in the Protection Group
$volumes = $pg.volumes

# Go through each FlashArray volume in the Protection Group and have Veeam take snapshots of each volume.
foreach ($vol in $volumes)
	{
		$volume = Get-StoragePluginVolume -name $vol
	Add-StoragePluginSnapshot -volume $volume -name $(get-date -format FileDateTime)
	}
