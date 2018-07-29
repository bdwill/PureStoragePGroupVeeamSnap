# Snapshots of Pure Storage Protection Groups by Veeam

This is a PowerShell script that enables Veeam Backup and Replication to create snapshots of all volumes in a FlashArray Protection Group. The targeted use case is to run this script on a user-defined basis in Windows Task Scheduler.

### Known Limitations

This version only supports volume-based Protection Groups. If your Protection Group's members are hosts or host groups, the script will not work. I anticipate fixing this in an upcoming release as well as adding the ability to specify a volume instead of a Protection Group. Additionally, this script doesn't limit to the number of snapshots taken so please monitor your usage. A future version will address this issue as well.

Author: Brandon Willmott, Pure Storage Systems Engineer

For more information, visit https://bdwill.wordpress.com
