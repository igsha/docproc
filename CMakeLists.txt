cmake_minimum_required(VERSION 3.12)
project(docproc VERSION 0.3.2 LANGUAGES NONE)

include(CTest)
include(CMakePackageConfigHelpers)

write_basic_package_version_file(${PROJECT_NAME}-config-version.cmake COMPATIBILITY AnyNewerVersion)
set(PROJECT_DIR ${CMAKE_SOURCE_DIR}/pandoc ${CMAKE_SOURCE_DIR}/image)
configure_file(config.cmake.in ${PROJECT_NAME}-config.cmake @ONLY)
set(PROJECT_DIR "\${CMAKE_CURRENT_LIST_DIR}/pandoc" "\${CMAKE_CURRENT_LIST_DIR}/image")
configure_file(config.cmake.in install/${PROJECT_NAME}-config.cmake @ONLY)

install(DIRECTORY image pandoc DESTINATION share/cmake/${PROJECT_NAME})
install(FILES
    ${CMAKE_BINARY_DIR}/install/${PROJECT_NAME}-config.cmake
    ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    DESTINATION share/cmake/${PROJECT_NAME}
)

if(BUILD_TESTING)
    set(ENV{docproc_DIR} ${CMAKE_BINARY_DIR})
    add_subdirectory(tests)
endif()

list(APPEND CPACK_GENERATOR TGZ)
set(CPACK_SYSTEM_NAME "all")
set(CPACK_PACKAGE_CONTACT "igsha")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "cmake >= 3.12")
include(CPack)
