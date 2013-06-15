

REM Nightly build of CTKAppLauncher vs2008 32bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-32bits_CTKAppLauncher_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2008-32bits_CTKAppLauncher_release_nightly.txt

REM Nightly build of slicer vs2008 64bits
"C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicer4_release_nightly.txt

REM Nightly build of slicer vs2008 32bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-32bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-32bits_slicer4_release_nightly.txt

REM Nightly build of slicer extensions testing vs2008 64bits
"C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_testing_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_testing_release_nightly.txt

REM Nightly build of slicer extensions vs2008 64bits
"C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_release_nightly.txt

REM Nightly build of slicer 4.2 extensions vs2008 64bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_42_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_42_release_nightly.txt

REM Nightly build of slicer extensions testing vs2008 32bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-32bits_slicerextensions_testing_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2008-32bits_slicerextensions_testing_release_nightly.txt

REM Nightly build of slicer extensions vs2008 32bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-32bits_slicerextensions_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2008-32bits_slicerextensions_release_nightly.txt

REM Nightly build of slicer 4.1.1 extensions vs2008 32bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-32bits_slicerextensions_411_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2008-32bits_slicerextensions_411_release_nightly.txt

REM Nightly build of slicer 4.2 extensions vs2008 32bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-32bits_slicerextensions_42_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2008-32bits_slicerextensions_42_release_nightly.txt

REM Nightly build of slicer vs2010 64bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2010-64bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2010-64bits_slicer4_release_nightly.txt

REM Nightly build of slicer vs2010 32bits
REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2010-32bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2010-32bits_slicer4_release_nightly.txt

REM cd "C:\Dashboards\Client"

REM "C:\D\Support\CMake 2.8.10.2\bin\ctest.exe" -S "C:\Dashboards\Client\factory.kitware.ctest" -V -O "C:\Dashboards\Logs\itk_cdash_at_home.txt"
