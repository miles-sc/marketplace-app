cmake_minimum_required(VERSION 3.10)
project(step_processing LANGUAGES CXX)

# tell CMake where the OCC headers are
set(OpenCASCADE_INCLUDE_DIR "/usr/include/oce")

# list the needed OCC libraries
set(OpenCASCADE_LIBRARIES
  TKernel
  TKMath
  TKG2d
  TKBRep
  TKPrim
  TKGeomBase
  TKTopAlgo
  TKSTEP
  TKSTEPAttr
  TKXSBase
  TKSTEP209
  TKXDESTEP
  TKXCAF
  TKCAF
  TKV3d
  TKOpenGl
)

# build volume tool
add_executable(step_volume step_volume.cpp)
target_include_directories(step_volume PRIVATE ${OpenCASCADE_INCLUDE_DIR})
target_link_libraries(step_volume PRIVATE ${OpenCASCADE_LIBRARIES})

# build surface‐area tool
add_executable(step_surface_area step_surface_area.cpp)
target_include_directories(step_surface_area PRIVATE ${OpenCASCADE_INCLUDE_DIR})
target_link_libraries(step_surface_area PRIVATE ${OpenCASCADE_LIBRARIES})
