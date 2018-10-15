# Mandatory options: PLANTUML_EXE, DOT_EXE, IMAGEMAGICK_EXE

include(CMakeParseArguments)

foreach(_num RANGE 0 ${CMAKE_ARGC})
    list(APPEND _args ${CMAKE_ARGV${_num}})
endforeach()
cmake_parse_arguments(_compiler "" "SOURCE;OUTPUT" "DEFINES;INCLUDES;FLAGS" ${_args})

get_filename_component(_src_ext ${_compiler_SOURCE} EXT)
string(REGEX MATCH "\\.([A-Za-z0-9]+)$" _ext ${_compiler_OUTPUT})
set(_ext ${CMAKE_MATCH_1})

if(_src_ext MATCHES uml)
    execute_process(COMMAND ${PLANTUML_EXE} ${_compiler_DEFINES} ${_compiler_INCLUDES} ${_compiler_FLAGS} -pipe -t${_ext}
        INPUT_FILE ${_compiler_SOURCE} OUTPUT_FILE ${_compiler_OUTPUT}
        RESULT_VARIABLE _result ERROR_VARIABLE _error_message
    )
elseif(_src_ext MATCHES dot)
    execute_process(COMMAND ${DOT_EXE} ${_compiler_SOURCE} ${_compiler_DEFINES} ${_compiler_INCLUDES} ${_compiler_FLAGS} -T${_ext} -o ${_compiler_OUTPUT}
        RESULT_VARIABLE _result ERROR_VARIABLE _error_message
    )
else()
    execute_process(COMMAND ${IMAGEMAGICK_EXE} ${_compiler_DEFINES} ${_compiler_INCLUDES} ${_compiler_FLAGS} ${_compiler_SOURCE} -o ${_compiler_OUTPUT}
        RESULT_VARIABLE _result ERROR_VARIABLE _error_message
    )
endif()

if(_result)
    message(FATAL_ERROR "${_error_message}")
endif()
