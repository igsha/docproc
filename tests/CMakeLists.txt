find_package(docproc REQUIRED)

file(GLOB SRCS *.md)
add_library(mylib ${SRCS})
target_compile_options(mylib PUBLIC -Fpandoc-crossref -Fpandoc-citeproc)

add_document(docx mydocx ../README.md)
target_link_libraries(mydocx mylib)

add_document(html myhtml ../README.md)
target_link_libraries(myhtml mylib)
set_target_properties(myhtml PROPERTIES LINK_FLAGS -Vpagetitle=myhtml)
