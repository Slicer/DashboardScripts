set(package_prefix "SlicerSALT")
if(APPLE)
  set(DASHBOARDS_DIR "/Volumes/D")
  set(Slicer_RELEASE_TYPE "P")
  set(package_suffix "macosx-amd64.dmg")
elseif(UNIX)
  set(DASHBOARDS_DIR "/home/kitware/Dashboards/Slicer")
  set(Slicer_RELEASE_TYPE "Preview")
  set(package_suffix "linux-amd64.tar.gz")
elseif(WIN32)
  set(DASHBOARDS_DIR "D:/D")
  set(Slicer_RELEASE_TYPE "P")
  set(package_suffix "win-amd64.exe")
else()
  message(FATAL_ERRROR "unknown system")
endif()
set(PACKAGE_DIR "${DASHBOARDS_DIR}/${Slicer_RELEASE_TYPE}/SSALT-0-build/Slicer-build")
if(NOT EXISTS ${PACKAGE_DIR})
  message(FATAL_ERROR "PACKAGE_DIR does not exist ! [${PACKAGE_DIR}]")
endif()

include("${DASHBOARDS_DIR}/Support/Kitware-SlicerSALTPackagesCredential.cmake")
set(girder_client_executable $ENV{GIRDER_CLIENT_EXECUTABLE})
set(girder_api_url $ENV{SLICERSALT_GIRDER_URL}/api/v1)
set(girder_api_key $ENV{SLICERSALT_GIRDER_API_KEY})
set(girder_upload_folder_id "5bd85a568d777f06b9402dad") # NIH Shape Analysis Toolbox/SlicerSALT-Public-Packages/Nightly

#-----------------------------------------------------------------------------
set(msg "Looking up ${package_prefix} package in [${PACKAGE_DIR}]")
message("${msg}")
file(GLOB packages
  LIST_DIRECTORIES FALSE
  RELATIVE ${PACKAGE_DIR}
  "${PACKAGE_DIR}/${package_prefix}-*${package_suffix}"
  )
list(LENGTH packages package_count)
if(NOT package_count EQUAL 1)
  message(FATAL_ERROR "Failed to look up package. Found ${package_count} [${packages}]")
endif()
set(p ${packages})
get_filename_component(package_name "${p}" NAME)
message("${msg} - ${package_name}")

#-----------------------------------------------------------------------------
set(msg "Uploading [${package_name}] to [${girder_api_url}]")
message("${msg}")
set(error_file ${PACKAGE_DIR}/girder_upload_errors.txt)
execute_process(COMMAND
  ${CMAKE_COMMAND} -E env
    LC_ALL=en_US.UTF-8
    LANG=en_US.UTF-8
  ${girder_client_executable}
    --api-url ${girder_api_url}
    --api-key ${girder_api_key}
    upload ${girder_upload_folder_id} --reuse ${package_name}
  WORKING_DIRECTORY ${PACKAGE_DIR}
  RESULT_VARIABLE girder_upload_status
  ERROR_FILE ${error_file}
  )
if(NOT girder_upload_status EQUAL 0)
  message(FATAL_ERROR "Failed to upload extension using ${girder_client_executable}.
See ${error_file} for more details.")
endif()
message("${msg} - done")
