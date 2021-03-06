cmake_minimum_required(VERSION 3.5)
option(_HRP_BUILD_SERVER "If you enable _HRP_BUILD_SERVER the server will build" ON)
if(${_HRP_BUILD_SERVER})
project(HomeRPServer LANGUAGES CXX C)
else()
project(HomeRPClient LANGUAGES CXX C)
endif()
message(${CMAKE_PROJECT_NAME})
include(cmake/GitUtils.cmake)
#include(GoogleTest.cmake)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_CXX_STANDARD 20)
add_definitions (-DCMAKE_CXX_COMPILER_ARG1=-std=c++20)
add_definitions(-DCMAKE_RC_COMPILER=windres)
#add_definitions(-Wfatal-errors)
SET(_QX_ENABLE_QT_NETWORK ON CACHE BOOL "If you enable _QX_ENABLE_QT_NETWORK option, then QxService and QxHttpServer modules of QxOrm library will be available (network transactions to transfer persistent data layer + standalone multi-threaded HTTP 1.1 web server")
SET(_QX_ENABLE_QT_GUI ON CACHE BOOL "If you enable _QX_ENABLE_QT_GUI option, then QxOrm library will be able to serialize Qt Gui objects (QBrush, QColor, QFont, QImage, QMatrix, QPicture, QPixmap, QRegion)")
SET(_QX_UNITY_BUILD ON CACHE BOOL "If you enable _QX_UNITY_BUILD option, then QxOrm library will be built faster (using only 1 'all.cpp' source file)")
SET(_QX_USE_QSTRINGBUILDER ON CACHE BOOL "If you enable _QX_USE_QSTRINGBUILDER option, then QxOrm library will define QT_USE_QSTRINGBUILDER compilation option of Qt library to provide some optimizations with QString class")

function(add_rep name rep)
if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/reps/${name}")
git_clone(
        PROJECT_NAME    ${name}
        GIT_URL         https://github.com/${rep}/${name}.git
        DIRECTORY       ${CMAKE_CURRENT_LIST_DIR}/reps
        GIT_BRANCH      master)
endif()
add_subdirectory(reps/${name})
endfunction()

set(EXEC_FOLDER "bin")

if(WIN32)
set(LIB_FOLDER "bin")
else()
set(LIB_FOLDER "lib")
endif()
set(INCLUDE_FOLDER "include")
set(PLUGIN_FOLDER "${EXEC_FOLDER}/plugins")
add_rep(QxOrm Mabenan)
set_target_properties(QxOrm PROPERTIES
                      ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
                      LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
                      RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
                      ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/lib"
                      LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/lib"
                      RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/bin"
                      ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/lib"
                      LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/lib"
                      RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/bin"
                      ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_BINARY_DIR}/lib"
                      LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_BINARY_DIR}/lib"
                      RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_BINARY_DIR}/bin"
                      ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_BINARY_DIR}/lib"
                      LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_BINARY_DIR}/lib"
                      RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_BINARY_DIR}/bin"
                     )
                 add_rep(QxOrmHelperMacros Mabenan)
if(_HRP_BUILD_SERVER)
add_rep(ApplicationServer Mabenan)
add_rep(ApplicationServerListCommands Mabenan)
add_rep(ApplicationServerQxServer Mabenan)
else()
add_rep(ApplicationClient Mabenan)
endif()
add_rep(HERP.AuthorizationModule Mabenan)

SET(CPACK_GENERATOR "DEB")
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "KK") #required
INCLUDE(CPack)
