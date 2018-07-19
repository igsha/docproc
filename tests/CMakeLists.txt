find_package(docproc REQUIRED)

file(GLOB SRCS *.md)
add_library(mylib ${SRCS})
target_compile_options(mylib PUBLIC -F${CMAKE_CURRENT_SOURCE_DIR}/pandoc-version)

add_document(docx mydocx ../README.rst)
target_link_libraries(mydocx mylib)

add_document(html myhtml ../README.rst)
target_link_libraries(myhtml mylib "-V pagetitle=myhtml")
#the same effect: set_target_properties(myhtml PROPERTIES LINK_FLAGS "-V pagetitle=myhtml")
