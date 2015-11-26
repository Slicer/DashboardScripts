

REM Nightly build of slicer vs2008 64bits
"C:\D\Support\CMake 3.1.0-rc3\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicer4_release_nightly.txt

REM Nightly build of slicer extensions testing vs2008 64bits
"C:\D\Support\CMake 3.1.0-rc3\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_testing_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_testing_release_nightly.txt

REM Nightly build of slicer extensions vs2008 64bits
"C:\D\Support\CMake 3.1.0-rc3\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_release_nightly.txt

REM Nightly build of slicer 4.5 extensions vs2008 64bits
"C:\D\Support\CMake 3.1.0-rc3\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly.txt

:: Publish Slicer extension module metadata
::call C:\D\DashboardScripts\factory-south-win7-slicer-publish-extension-module-metadata.bat >C:\D\Logs\factory-south-win7-slicer-publish-extension-module-metadata.log 2>&1

REM Nightly build of slicer vs2010 64bits
REM "C:\D\Support\CMake 3.1.0-rc3\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2010-64bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2010-64bits_slicer4_release_nightly.txt

REM cd "C:\Dashboards\Client"

REM "C:\D\Support\CMake 3.1.0-rc3\bin\ctest.exe" -S "C:\Dashboards\Client\factory.kitware.ctest" -V -O "C:\Dashboards\Logs\itk_cdash_at_home.txt"
