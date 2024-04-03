cmake_minimum_required(VERSION 3.16)

project(Warehousing VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appWarehousing
    main.cpp
)


qt_add_qml_module(appWarehousing
    URI Warehousing
    VERSION 1.0
    QML_FILES Main.qml CustomButton.qml Goods.qml
)


set_target_properties(appWarehousing PROPERTIES
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWarehousing
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appWarehousing
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
