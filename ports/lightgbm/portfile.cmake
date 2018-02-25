if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    message("lightgbm currently only supports dynamic linkage")
    set(VCPKG_LIBRARY_LINKAGE "dynamic")
endif()

if(VCPKG_CRT_LINKAGE STREQUAL "static")
    message(FATAL_ERROR "lightgbm cannot be built with the static CRT")
endif()

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Microsoft/lightgbm
    REF v2.1.0
    SHA512 7381e97789188755f37da81b7052d5e3b4d5da2b741ad05bedd747b0288942e1b9d46c4604b667735b501bcb8bb73e555e808a380a0d8ac95a348b62347c8a75
    HEAD_REF master
)
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(INSTALL
    ${SOURCE_PATH}/LICENSE
    DESTINATION ${CURRENT_PACKAGES_DIR}/share/lightgbm RENAME copyright)

if(EXISTS ${CURRENT_PACKAGES_DIR}/bin/lightgbm.exe)
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/lightgbm)
    file(RENAME ${CURRENT_PACKAGES_DIR}/bin/lightgbm.exe ${CURRENT_PACKAGES_DIR}/tools/lightgbm/lightgbm.exe)
    vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/lightgbm)
endif()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/lightgbm.exe ${CURRENT_PACKAGES_DIR}/debug/include)

vcpkg_copy_pdbs()

