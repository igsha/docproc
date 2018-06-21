cmake_minimum_required(VERSION 3.7)
project(docproc VERSION 0.2.1 LANGUAGES NONE)

include(CTest)
include(CMakePackageConfigHelpers)

write_basic_package_version_file(${PROJECT_NAME}-config-version.cmake COMPATIBILITY AnyNewerVersion)
set(PROJECT_DIR ${CMAKE_SOURCE_DIR}/src)
configure_file(config.cmake.in ${PROJECT_NAME}-config.cmake @ONLY)
set(PROJECT_DIR "\${CMAKE_CURRENT_LIST_DIR}")
configure_file(config.cmake.in install/${PROJECT_NAME}-config.cmake @ONLY)

install(DIRECTORY src/ DESTINATION share/cmake/${PROJECT_NAME})
install(FILES
    ${CMAKE_BINARY_DIR}/install/${PROJECT_NAME}-config.cmake
    ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
    DESTINATION share/cmake/${PROJECT_NAME}
)
export(PACKAGE ${PROJECT_NAME})

if(BUILD_TESTING)
    add_subdirectory(tests)
endif()

list(APPEND CPACK_GENERATOR TGZ)
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_SYSTEM_NAME "all")
set(CPACK_PACKAGE_CONTACT "igsha")
include(CPack)
