set(_IMAGE_COMPILER_WORKS 0)

if(CMAKE_IMAGE_COMPILER)
    set(_IMAGE_COMPILER_WORKS 1)
endif()

set(CMAKE_IMAGE_COMPILER_WORKS ${_IMAGE_COMPILER_WORKS} CACHE INTERNAL "")
