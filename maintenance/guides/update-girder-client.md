
Update Girder client
====================

This guide allows to update the installation of the [Girder client](https://girder.readthedocs.io/en/stable/python-client.html#python-client)
allowing to download and upload data from any Girder server.

## Step 1: Open bash terminal and clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

## Step 2: Install new version of the client on each build machine

### macOS and Linux

Since these machines have both SSH installed, the following steps will remotely execute
the install scripts:

1. Open bash terminal and execute the following statements:

```
cd maintenance
make remote-install-girder-client
```

### Window

1. Connect to [overload](../overload/REMOTE_IP) using VNC

2. Open a command line terminal

3. If needed, create the environment executing the following statements:

```
D:
C:\Python36-x64\Scripts\virtualenv.exe D:\Support\girder_client-venv
```

4. Finally, execute the following statements:

```
D:
D:\Support\girder_client-venv\Scripts\pip install -U girder_client
```
