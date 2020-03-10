cmake_minimum_required(VERSION 3.5)

project(HomeERP LANGUAGES CXX C)
message(${CMAKE_PROJECT_NAME})
include(cmake/GitUtils.cmake)
include(GoogleTest.cmake)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_CXX_STANDARD 20)
add_definitions (-DCMAKE_CXX_COMPILER_ARG1=-std=c++20)
function(add_rep name)
if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/reps/${name}")
git_clone(
        PROJECT_NAME    ${name}
        GIT_URL         https://github.com/mabenan/${name}.git
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
add_rep(ApplicationServer)
add_rep(ApplicationServerListCommands)
add_rep(ODataServer)
add_rep(ApplicationServerODataPlugin)
add_rep(HERP.AuthorizationModule)
add_rep(HERP.FrontendProvider)
add_rep(QxOrm)