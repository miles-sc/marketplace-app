cmake_minimum_required(VERSION 3.10)
project(step_processing LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find OpenCASCADE
set(OpenCASCADE_DIR "/opt/homebrew/opt/opencascade/lib/cmake/opencascade")
find_package(OpenCASCADE REQUIRED)

# Add the library directory to linker search path
link_directories(/opt/homebrew/opt/opencascade/lib)

# build volume tool
add_executable(step_volume step_volume.cpp)
target_include_directories(step_volume PRIVATE ${OpenCASCADE_INCLUDE_DIR})
target_link_libraries(step_volume PRIVATE
  TKernel TKMath TKBRep TKGeomBase TKTopAlgo
  TKDESTEP TKXSBase TKXCAF TKCAF TKV3d
)

# build surface‐area tool
add_executable(step_surface_area step_surface_area.cpp)
target_include_directories(step_surface_area PRIVATE ${OpenCASCADE_INCLUDE_DIR})
target_link_libraries(step_surface_area PRIVATE
  TKernel TKMath TKBRep TKGeomBase TKTopAlgo
  TKDESTEP TKXSBase TKXCAF TKCAF TKV3d
)
