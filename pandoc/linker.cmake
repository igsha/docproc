# Mandatory options: COMPILER, NATIVE_EXT

include(CMakeParseArguments)

foreach(_num RANGE 0 ${CMAKE_ARGC})
    list(APPEND _args ${CMAKE_ARGV${_num}})
endforeach()
cmake_parse_arguments(_linker "" "OUTPUT" "FLAGS;OBJECTS" ${_args})

foreach(_obj ${_linker_OBJECTS})
    get_filename_component(_ext ${_obj} EXT)
    if(${_ext} MATCHES ${NATIVE_EXT} OR NOT EXISTS ${_obj})
        list(APPEND _standard_objects ${_obj})
    else()
        get_filename_component(_dir ${_obj} DIRECTORY)
        get_filename_component(_dir ${_dir} ABSOLUTE)
        list(APPEND _image_paths ${_dir})
    endif()
endforeach()

if(_image_paths)
    string(REPLACE ";" ":" _image_paths ".:${_image_paths}")
    set(_image_paths "--resource-path=${_image_paths}")
    list(APPEND _linker_FLAGS --self-contained)
endif()

set(_command ${COMPILER} ${_image_paths} ${_linker_FLAGS} ${_standard_objects} -o ${_linker_OUTPUT})
if($ENV{VERBOSE})
    message("${_command}")
endif()

execute_process(COMMAND ${_command} RESULT_VARIABLE _result ERROR_VARIABLE _error_message)
if(_result)
    message(FATAL_ERROR "${_error_message}")
endif()
