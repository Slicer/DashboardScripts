
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

### Windows

1. Connect to bluestreak using VNC

2. Open a command line terminal

3. Confirm the existing environment is available:

```
C:
dir C:\D\Support\girder_client-venv\Scripts\pip.exe
```

4. Finally, execute the following statements:

```
C:
C:\D\Support\girder_client-venv\Scripts\pip install -U girder_client
```
