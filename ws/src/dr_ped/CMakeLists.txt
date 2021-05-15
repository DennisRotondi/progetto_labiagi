cmake_minimum_required(VERSION 3.0.2)
project(dr_ped)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs   
  geometry_msgs
  message_generation
  tf
  tf2
)

## Generate messages in the 'msg' folder
add_message_files(
   FILES
   Obiettivo.msg
#  Message2.msg
)

## Generate services in the 'srv' folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate actions in the 'action' folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
# )

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
)

catkin_package(
   CATKIN_DEPENDS roscpp std_msgs
   CATKIN_DEPENDS message_runtime
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

add_executable(dr_ped src/dr_ped.cpp)
target_link_libraries(dr_ped ${catkin_LIBRARIES})
add_dependencies(dr_ped dr_ped_generate_messages_cpp)

## Declare a C++ library
# add_library(${PROJECT_NAME}
#   src/${PROJECT_NAME}/dr_ped.cpp
# )
