cmake_minimum_required(VERSION 3.10)
project(FP LANGUAGES CXX CUDA)
#find_package(CUDA REQUIRED)


#include_directories(CUDA_INCLUDE_DIRS ${CUDA_TOOLKIT_INCLUDE}
#                "${CMAKE_SOURCE_DIR}/src"
#                "${CMAKE_SOURCE_DIR}/include")

set(CUDA_INCLUDE_DIRS ${CUDA_TOOLKIT_INCLUDE}
        ${CMAKE_SOURCE_DIR}/src
        ${CMAKE_SOURCE_DIR}/include
        )


set(CMAKE_C_COMPILER /usr/bin/gcc-6 CACHE PATH "" FORCE)
set(CMAKE_CXX_COMPILER /usr/bin/g++-6 CACHE PATH "" FORCE)
set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -rdc=true -gencode arch=compute_50,code=sm_50")
set(CMAKE_C_FLAGS_DEBUG "-D_DEBUG")

add_library(gpu_library_fp_growth STATIC
        include/FPRadixTree.h
        include/FPHeaderTable.h
        include/FPGrowth.h
        src/FPRadixTree.cu
        src/FPHeaderTable.cu
        src/FPGrowth.cu
        )

add_library(cpu_library_fp_growth STATIC
        include/FPTransMap.h
        src/FPTransMap.cpp)

enable_testing()

target_compile_features(cpu_library_fp_growth PUBLIC cxx_std_11)

set_target_properties( cpu_library_fp_growth
        PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
add_executable(fp_cuda main.cu )
set_property(TARGET fp_cuda
        PROPERTY CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries( fp_cuda cpu_library_fp_growth gpu_library_fp_growth)

add_test(test_fp main.cu)


if(APPLE)
    # We need to add the path to the driver (libcuda.dylib) as an rpath,
    # so that the static cuda runtime can find it at runtime.
    set_property(TARGET fp_cuda
            PROPERTY
            BUILD_RPATH ${CMAKE_CUDA_IMPLICIT_LINK_DIRECTORIES})
endif()