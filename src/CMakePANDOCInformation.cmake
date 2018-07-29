set(CMAKE_PANDOC_SOURCE_FILE_EXTENSIONS md rst yml)

set(CMAKE_PANDOC_COMPILE_OBJECT "<CMAKE_PANDOC_COMPILER> <DEFINES> <INCLUDES> <FLAGS> <SOURCE> -o <OBJECT>")
set(CMAKE_PANDOC_OUTPUT_EXTENSION .json)

set(CMAKE_PANDOC_CREATE_STATIC_LIBRARY "<CMAKE_PANDOC_COMPILER> <OBJECTS> -o <TARGET>")
set(CMAKE_STATIC_LIBRARY_SUFFIX_PANDOC .json)

set(CMAKE_PANDOC_LINK_EXECUTABLE "<CMAKE_PANDOC_COMPILER> <FLAGS> <LINK_FLAGS> -s <OBJECTS> <LINK_LIBRARIES> -o <TARGET>")
set(CMAKE_EXECUTABLE_SUFFIX_PANDOC .html)

macro(add_document _format _target)
    add_executable(${_target} ${ARGN})
    set_target_properties(${_target} PROPERTIES SUFFIX ".${_format}")
endmacro()

macro(add_html)
    add_document(html ${ARGN})
endmacro()

macro(add_docx)
    add_document(docx ${ARGN})
endmacro()
