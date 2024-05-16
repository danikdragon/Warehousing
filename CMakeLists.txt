cmake_minimum_required(VERSION 3.27)
project(Warehousing VERSION 0.1 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)
FetchContent_Declare(json URL https://github.com/nlohmann/json/releases/download/v3.11.3/json.tar.xz)
FetchContent_MakeAvailable(json)

set(RESOURCES resources.qrc)
find_package(Qt6 6.6 REQUIRED COMPONENTS Quick Core Qml)
qt_add_resources(RESOURCES_ADDED ${RESOURCES})
qt_standard_project_setup()

add_executable(appWarehousing
        main.cpp ${RESOURCES_ADDED}
        source/Suppliers.cpp
        include/Suppliers.h
)

target_link_libraries(appWarehousing PUBLIC nlohmann_json::nlohmann_json)

qt_add_qml_module(appWarehousing
    URI Warehousing
    VERSION 1.0
        QML_FILES
        QML/Main.qml
        QML/MenuButton.qml
        QML/CustomButton.qml
        QML/CustomTextArea.qml
        QML/Goods.qml
        QML/MainPage.qml
        QML/CreateGoods.qml
        QML/SuppliersPage.qml
        QML/Answer.qml
        QML/Categories.qml
        QML/GridGoods.qml
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
#add_subdirectory(include)