cmake_minimum_required(VERSION 3.10)
project(qt-hello)

find_package(Qt5 REQUIRED COMPONENTS Widgets)

add_executable(qt-hello main.cpp)
target_link_libraries(qt-hello Qt5::Widgets)
