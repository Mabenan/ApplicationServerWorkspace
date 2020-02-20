include(cmake/GitUtils.cmake)
function(add_rep name)
git_clone(
        PROJECT_NAME    ${name}
        GIT_URL         https://github.com/mabenan/${name}.git
        DIRECTORY       ${CMAKE_CURRENT_LIST_DIR}/reps
        GIT_BRANCH      master)
file(MAKE_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/reps/${name}/build")
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" "${CMAKE_CURRENT_LIST_DIR}/reps/${name}"
  RESULT_VARIABLE result
  WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/reps/${name}/build" )
execute_process(COMMAND ${CMAKE_COMMAND} --build "${CMAKE_CURRENT_LIST_DIR}/reps/${name}/build"
  RESULT_VARIABLE result
  WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/reps/${name}/build"  )
endfunction()

add_rep(ApplicationServer)
add_rep(ApplicationServerListCommands)
add_rep(ODataServer)
add_rep(ApplicationServerODataPlugin)
