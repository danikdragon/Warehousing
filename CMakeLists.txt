cmake_minimum_required(VERSION 3.20)

project(Warehousing VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_POLICY_DEFAULT_CMP0068 NEW)
set(RESOURCES resources.qrc)

find_package(Qt6 6.6 REQUIRED COMPONENTS Quick Core Qml)

qt_add_resources(RESOURCES_ADDED ${RESOURCES})
qt_standard_project_setup()

qt_add_executable(appWarehousing
        source/main.cpp ${RESOURCES_ADDED}
)

qt_add_qml_module(appWarehousing
    URI Warehousing
    VERSION 1.0
    QML_FILES QML/Main.qml QML/CustomButton.qml QML/Goods.qml QML/MenuButton.qml QML/Page1.qml
)

set_target_properties(appWarehousing PROPERTIES
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWarehousing
    PRIVATE
        Qt6::Quick
        Qt6::Core
        Qt6::Qml
)

