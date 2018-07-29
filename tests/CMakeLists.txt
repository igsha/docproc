find_package(docproc REQUIRED)

file(GLOB SRCS *.md)
add_library(mylib ${SRCS})
target_compile_options(mylib PUBLIC -F${CMAKE_CURRENT_SOURCE_DIR}/pandoc-version)

add_docx(mydocx ../README.rst)
target_link_libraries(mydocx mylib)

add_html(myhtml ../README.rst)
target_link_libraries(myhtml mylib "-V pagetitle=myhtml")
#the same effect: set_target_properties(myhtml PROPERTIES LINK_FLAGS "-V pagetitle=myhtml")

add_html(metadata_test ../README.rst metadata.yml)
target_link_libraries(metadata_test "-V pagetitle='metadata test'")
add_test(NAME metadata COMMAND ${CMAKE_COMMAND}
    -DFILENAME=$<TARGET_FILE:metadata_test> -DREGEXSTR=stylesheet.+https://.+styles\\.css -DSILENT=ON
    -P ${CMAKE_CURRENT_SOURCE_DIR}/grep.cmake
)

add_html(plantuml_test plantuml.rst)
convert_image_for(TARGET plantuml_test FILES diagram.uml FORMAT svg)
target_link_libraries(plantuml_test PUBLIC "-V pagetitle='plantuml test'" --self-contained)
add_test(NAME plantuml COMMAND ${CMAKE_COMMAND}
    -DFILENAME=$<TARGET_FILE:plantuml_test> "-DREGEXSTR=img src=\\\"data:image/svg\\+xml\\;base64" -DSILENT=ON
    -P ${CMAKE_CURRENT_SOURCE_DIR}/grep.cmake
)
