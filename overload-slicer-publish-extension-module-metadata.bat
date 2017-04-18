@echo off

set PATH=C:\Program Files (x86)\Git\bin\;%PATH%

set DASHBOARD_DIR=D:\D
set SLICER_WIKI_SCRIPTS_DIR=%DASHBOARD_DIR%\Support\slicer-wiki-scripts

::Clone
if not exist %SLICER_WIKI_SCRIPTS_DIR% ( git clone git://github.com/Slicer/slicer-wiki-scripts %SLICER_WIKI_SCRIPTS_DIR% )

pushd %SLICER_WIKI_SCRIPTS_DIR%

:: Update discarding local changes
git reset --hard && git checkout master && git fetch origin && git reset --hard origin/master

::
:: Release
::
::set PACKAGE_VERSION=462
::set SLICER_BUILD_DIR=%DASHBOARD_DIR%\P\Slicer-%PACKAGE_VERSION%-package\Slicer-build
::set SLICER_EXTENSIONS_INDEX_BUILD_DIR=%DASHBOARD_DIR%\N\S-%PACKAGE_VERSION%-E-b

::%SLICER_BUILD_DIR%\Slicer.exe --launch python.exe slicer_wiki_extension_module_listing.py publish-extension-module-metadata "%SLICER_BUILD_DIR%" "%SLICER_EXTENSIONS_INDEX_BUILD_DIR%"

::
:: Nightly
::
set DIRECTORY_IDENTIFIER=1
set SLICER_BUILD_DIR=%DASHBOARD_DIR%\N\Slicer-%DIRECTORY_IDENTIFIER%-package\Slicer-build
set SLICER_EXTENSIONS_INDEX_BUILD_DIR=%DASHBOARD_DIR%\N\S-%DIRECTORY_IDENTIFIER%-E-b

if exist %SLICER_BUILD_DIR%\Slicer.exe (
  %SLICER_BUILD_DIR%\Slicer.exe --launch python.exe slicer_wiki_extension_module_listing.py publish-extension-module-metadata "%SLICER_BUILD_DIR%" "%SLICER_EXTENSIONS_INDEX_BUILD_DIR%"
) else (
  echo "Skipping 'publish-extension-module-metadata': %SLICER_BUILD_DIR%\Slicer.exe does NOT exists"
)

popd
