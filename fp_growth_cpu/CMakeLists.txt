cmake_minimum_required(VERSION 3.10)
project(fp_growth_cpu LANGUAGES C CXX)

include_directories(${CMAKE_SOURCE_DIR}/src ${CMAKE_SOURCE_DIR}/include)

set(CMAKE_CXX_COMPILER /usr/bin/g++-6 CACHE PATH "" FORCE)
set(CMAKE_C_FLAGS_DEBUG "-D_DEBUG")

add_library(library_fp_growth STATIC
        include/fptree.hpp
        src/fptree.cpp
        )

add_executable(fp_cpu src/main.cpp)
target_link_libraries(fp_cpu PUBLIC library_fp_growth)