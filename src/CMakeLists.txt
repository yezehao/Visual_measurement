cmake_minimum_required(VERSION 3.16)
project(Assignment4)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(OpenCV 4.2.0 EXACT REQUIRED)
include_directories ("/usr/include/opencv4/")

include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(ZY_G ZY_G.cpp)
target_link_libraries(ZY_G ${OpenCV_LIBS})

add_executable(ZY_S ZY_S.cpp)
target_link_libraries(ZY_S ${OpenCV_LIBS})

add_executable(ZY_C ZY_C.cpp)
target_link_libraries(ZY_C ${OpenCV_LIBS})

add_executable(ZY_H ZY_H.cpp)
target_link_libraries(ZY_H ${OpenCV_LIBS})

add_executable(ZY_backsub ZY_backsub.cpp)
target_link_libraries(ZY_backsub ${OpenCV_LIBS})
