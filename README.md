# Snapshots of Pure Storage Protection Groups by Veeam

This is a PowerShell script that enables Veeam Backup and Replication to create snapshots of all volumes in a FlashArray Protection Group. The targeted use case is to run this script on a user-defined basis in Windows Task Scheduler.

### Known Limitations

This version only supports volume-based Protection Groups. If your Protection Group's members are hosts or host groups, the script will not work.

Author: Brandon Willmott, Pure Storage Systems Engineer

For more information, visit https://bdwill.wordpress.com
