if(NOT CMAKE_PANDOC_COMPILER)
    find_program(CMAKE_PANDOC_COMPILER pandoc pandoc.exe)
endif()

set(CMAKE_PANDOC_COMPILER_ENV_VAR "PANDOC_EXE")

configure_file(${CMAKE_CURRENT_LIST_DIR}/CMakePANDOCCompiler.cmake.in ${CMAKE_PLATFORM_INFO_DIR}/CMakePANDOCCompiler.cmake @ONLY)
