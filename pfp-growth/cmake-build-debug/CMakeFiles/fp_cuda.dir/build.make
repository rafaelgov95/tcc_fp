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
include CMakeFiles/fp_cuda.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/fp_cuda.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/fp_cuda.dir/flags.make

CMakeFiles/fp_cuda.dir/main.cu.o: CMakeFiles/fp_cuda.dir/flags.make
CMakeFiles/fp_cuda.dir/main.cu.o: ../main.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CUDA object CMakeFiles/fp_cuda.dir/main.cu.o"
	/opt/cuda/bin/nvcc  $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/rafael/Documentos/tcc_fp/pfp-growth/main.cu -o CMakeFiles/fp_cuda.dir/main.cu.o

CMakeFiles/fp_cuda.dir/main.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/fp_cuda.dir/main.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/fp_cuda.dir/main.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/fp_cuda.dir/main.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/fp_cuda.dir/main.cu.o.requires:

.PHONY : CMakeFiles/fp_cuda.dir/main.cu.o.requires

CMakeFiles/fp_cuda.dir/main.cu.o.provides: CMakeFiles/fp_cuda.dir/main.cu.o.requires
	$(MAKE) -f CMakeFiles/fp_cuda.dir/build.make CMakeFiles/fp_cuda.dir/main.cu.o.provides.build
.PHONY : CMakeFiles/fp_cuda.dir/main.cu.o.provides

CMakeFiles/fp_cuda.dir/main.cu.o.provides.build: CMakeFiles/fp_cuda.dir/main.cu.o


CMakeFiles/fp_cuda.dir/src/Kernel.cu.o: CMakeFiles/fp_cuda.dir/flags.make
CMakeFiles/fp_cuda.dir/src/Kernel.cu.o: ../src/Kernel.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CUDA object CMakeFiles/fp_cuda.dir/src/Kernel.cu.o"
	/opt/cuda/bin/nvcc  $(CUDA_DEFINES) $(CUDA_INCLUDES) $(CUDA_FLAGS) -x cu -dc /home/rafael/Documentos/tcc_fp/pfp-growth/src/Kernel.cu -o CMakeFiles/fp_cuda.dir/src/Kernel.cu.o

CMakeFiles/fp_cuda.dir/src/Kernel.cu.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CUDA source to CMakeFiles/fp_cuda.dir/src/Kernel.cu.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_PREPROCESSED_SOURCE

CMakeFiles/fp_cuda.dir/src/Kernel.cu.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CUDA source to assembly CMakeFiles/fp_cuda.dir/src/Kernel.cu.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CUDA_CREATE_ASSEMBLY_SOURCE

CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.requires:

.PHONY : CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.requires

CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.provides: CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.requires
	$(MAKE) -f CMakeFiles/fp_cuda.dir/build.make CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.provides.build
.PHONY : CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.provides

CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.provides.build: CMakeFiles/fp_cuda.dir/src/Kernel.cu.o


# Object files for target fp_cuda
fp_cuda_OBJECTS = \
"CMakeFiles/fp_cuda.dir/main.cu.o" \
"CMakeFiles/fp_cuda.dir/src/Kernel.cu.o"

# External object files for target fp_cuda
fp_cuda_EXTERNAL_OBJECTS =

CMakeFiles/fp_cuda.dir/cmake_device_link.o: CMakeFiles/fp_cuda.dir/main.cu.o
CMakeFiles/fp_cuda.dir/cmake_device_link.o: CMakeFiles/fp_cuda.dir/src/Kernel.cu.o
CMakeFiles/fp_cuda.dir/cmake_device_link.o: CMakeFiles/fp_cuda.dir/build.make
CMakeFiles/fp_cuda.dir/cmake_device_link.o: libcpu_library_fp_growth.a
CMakeFiles/fp_cuda.dir/cmake_device_link.o: libgpu_library_fp_growth.a
CMakeFiles/fp_cuda.dir/cmake_device_link.o: CMakeFiles/fp_cuda.dir/dlink.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CUDA device code CMakeFiles/fp_cuda.dir/cmake_device_link.o"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fp_cuda.dir/dlink.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/fp_cuda.dir/build: CMakeFiles/fp_cuda.dir/cmake_device_link.o

.PHONY : CMakeFiles/fp_cuda.dir/build

# Object files for target fp_cuda
fp_cuda_OBJECTS = \
"CMakeFiles/fp_cuda.dir/main.cu.o" \
"CMakeFiles/fp_cuda.dir/src/Kernel.cu.o"

# External object files for target fp_cuda
fp_cuda_EXTERNAL_OBJECTS =

fp_cuda: CMakeFiles/fp_cuda.dir/main.cu.o
fp_cuda: CMakeFiles/fp_cuda.dir/src/Kernel.cu.o
fp_cuda: CMakeFiles/fp_cuda.dir/build.make
fp_cuda: libcpu_library_fp_growth.a
fp_cuda: libgpu_library_fp_growth.a
fp_cuda: CMakeFiles/fp_cuda.dir/cmake_device_link.o
fp_cuda: CMakeFiles/fp_cuda.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable fp_cuda"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fp_cuda.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/fp_cuda.dir/build: fp_cuda

.PHONY : CMakeFiles/fp_cuda.dir/build

CMakeFiles/fp_cuda.dir/requires: CMakeFiles/fp_cuda.dir/main.cu.o.requires
CMakeFiles/fp_cuda.dir/requires: CMakeFiles/fp_cuda.dir/src/Kernel.cu.o.requires

.PHONY : CMakeFiles/fp_cuda.dir/requires

CMakeFiles/fp_cuda.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/fp_cuda.dir/cmake_clean.cmake
.PHONY : CMakeFiles/fp_cuda.dir/clean

CMakeFiles/fp_cuda.dir/depend:
	cd /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rafael/Documentos/tcc_fp/pfp-growth /home/rafael/Documentos/tcc_fp/pfp-growth /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug /home/rafael/Documentos/tcc_fp/pfp-growth/cmake-build-debug/CMakeFiles/fp_cuda.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/fp_cuda.dir/depend

