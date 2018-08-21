# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/clion-2018.1.1/bin/cmake/bin/cmake

# The command to remove a file.
RM = /opt/clion-2018.1.1/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/rafael/Documentos/tcc_fp/pfp-growth

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/gpu_library_fp_growth.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/gpu_library_fp_growth.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gpu_library_fp_growth.dir/flags.make

CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o: CMakeFiles/gpu_library_fp_growth.dir/flags.make
CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o: ../src/kernel_pfp.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o"
	/opt/cuda/bin/nvcc  $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -c /home/rafael/Documentos/tcc_fp/pfp-growth/src/kernel_pfp.cu -o CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o

CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.requires:

.PHONY : CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.requires

CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.provides: CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.requires
	$(MAKE) -f CMakeFiles/gpu_library_fp_growth.dir/build.make CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.provides.build
.PHONY : CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.provides

CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.provides.build: CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o


CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o: CMakeFiles/gpu_library_fp_growth.dir/flags.make
CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o: ../src/pfp_tree_growth.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o"
	/usr/bin/g++-6  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o -c /home/rafael/Documentos/tcc_fp/pfp-growth/src/pfp_tree_growth.cpp

CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.i"
	/usr/bin/g++-6 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/rafael/Documentos/tcc_fp/pfp-growth/src/pfp_tree_growth.cpp > CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.i

CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.s"
	/usr/bin/g++-6 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/rafael/Documentos/tcc_fp/pfp-growth/src/pfp_tree_growth.cpp -o CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.s

CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.requires:

.PHONY : CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.requires

CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.provides: CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.requires
	$(MAKE) -f CMakeFiles/gpu_library_fp_growth.dir/build.make CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.provides.build
.PHONY : CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.provides

CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.provides.build: CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o


# Object files for target gpu_library_fp_growth
gpu_library_fp_growth_OBJECTS = \
"CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o" \
"CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o"

# External object files for target gpu_library_fp_growth
gpu_library_fp_growth_EXTERNAL_OBJECTS =

libgpu_library_fp_growth.a: CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o
libgpu_library_fp_growth.a: CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o
libgpu_library_fp_growth.a: CMakeFiles/gpu_library_fp_growth.dir/build.make
libgpu_library_fp_growth.a: CMakeFiles/gpu_library_fp_growth.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX static library libgpu_library_fp_growth.a"
	$(CMAKE_COMMAND) -P CMakeFiles/gpu_library_fp_growth.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gpu_library_fp_growth.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gpu_library_fp_growth.dir/build: libgpu_library_fp_growth.a

.PHONY : CMakeFiles/gpu_library_fp_growth.dir/build

CMakeFiles/gpu_library_fp_growth.dir/requires: CMakeFiles/gpu_library_fp_growth.dir/src/kernel_pfp.cu.o.requires
CMakeFiles/gpu_library_fp_growth.dir/requires: CMakeFiles/gpu_library_fp_growth.dir/src/pfp_tree_growth.cpp.o.requires

.PHONY : CMakeFiles/gpu_library_fp_growth.dir/requires

CMakeFiles/gpu_library_fp_growth.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gpu_library_fp_growth.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gpu_library_fp_growth.dir/clean

CMakeFiles/gpu_library_fp_growth.dir/depend:
	cd /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rafael/Documentos/tcc_fp/pfp-growth /home/rafael/Documentos/tcc_fp/pfp-growth /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles/gpu_library_fp_growth.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gpu_library_fp_growth.dir/depend

