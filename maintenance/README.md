Slicer Dashboard Maintenance
============================

You will find here scripts allowing to remotely update dashboard machines.

Script used to maintain a specific dashboard machine are found in a directory of the
same name. Information needed to remote connect to each dashboard are also stored in
text files in that same directory.

```
maintenance
  |--- <dashboard-name-1>
  |          |------ REMOTE_HOSTNAME
  |          |------ REMOTE_IP
  |          |------ REMOTE_USERNAME
  |          |------ maintenance_task_1.sh
  |          |------ maintenance_task_2.sh
  .          .
  .
  .
  |--- <dashboard-name-2>
  |          |------ REMOTE_HOSTNAME
  .          .
  .          .
[...]
```

**Gotcha**: Since remote execution of script is currently implemented only for Unix based
dashboards, directory associated with Windows dashboard will instead contain step-by-step
instructions. This may be improved in the future by using OpenSSH for windows:
* source: https://github.com/PowerShell/openssh-portable
* wiki: https://github.com/PowerShell/Win32-OpenSSH/wiki/Project-Status
* Microsoft blog posts:
  * 2017/12/15: [Using the OpenSSH Beta in Windows 10 Fall Creators Update and Windows Server 1709](https://blogs.msdn.microsoft.com/powershell/2017/12/15/using-the-openssh-beta-in-windows-10-fall-creators-update-and-windows-server-1709/)
  * 2015/10/10: [OpenSSH for Windows Update](https://blogs.msdn.microsoft.com/powershell/2015/10/19/openssh-for-windows-update/).

## Requirements

* These scripts references machines hosted in the Kitware, Inc. internal network, they will
  **NOT** if used externally.
* Your SSH public key **must** also be added to the `.ssh/authorized_keys` file of each dashboards.

