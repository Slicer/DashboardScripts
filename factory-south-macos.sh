# CMAKE_VERSION=3.22.1 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Clear Slicer settings
rm -rf /Users/kitware/.config/www.na-mic.org/
rm -rf /Users/kitware/.config/www.slicer.org/

# Clear reports to help avoid "The last time you opened ... Do you want to try to reopen its windows again?" dialog
rm -rf /Users/kitware/Library/Application\ Support/CrashReporter/*

# Clear "Saved Application State" specific to Slicer
rm -rf /Users/kitware/Library/Saved\ Application\ State/org.slicer.slicer.savedState/

# Medical Team Dashboard
/Volumes/D/Med/MedicalTeamDashboardScripts/factory-macos-south.sh > /Volumes/D/Med/Logs/factory-macos-south.log 2>&1

