# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "dr_ped: 1 messages, 0 services")

set(MSG_I_FLAGS "-Idr_ped:/home/dennis/progetto_labiagi/ws/src/dr_ped/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/melodic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(dr_ped_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg" NAME_WE)
add_custom_target(_dr_ped_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "dr_ped" "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(dr_ped
  "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dr_ped
)

### Generating Services

### Generating Module File
_generate_module_cpp(dr_ped
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dr_ped
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(dr_ped_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(dr_ped_generate_messages dr_ped_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg" NAME_WE)
add_dependencies(dr_ped_generate_messages_cpp _dr_ped_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dr_ped_gencpp)
add_dependencies(dr_ped_gencpp dr_ped_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dr_ped_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(dr_ped
  "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dr_ped
)

### Generating Services

### Generating Module File
_generate_module_eus(dr_ped
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dr_ped
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(dr_ped_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(dr_ped_generate_messages dr_ped_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg" NAME_WE)
add_dependencies(dr_ped_generate_messages_eus _dr_ped_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dr_ped_geneus)
add_dependencies(dr_ped_geneus dr_ped_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dr_ped_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(dr_ped
  "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dr_ped
)

### Generating Services

### Generating Module File
_generate_module_lisp(dr_ped
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dr_ped
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(dr_ped_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(dr_ped_generate_messages dr_ped_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg" NAME_WE)
add_dependencies(dr_ped_generate_messages_lisp _dr_ped_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dr_ped_genlisp)
add_dependencies(dr_ped_genlisp dr_ped_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dr_ped_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(dr_ped
  "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dr_ped
)

### Generating Services

### Generating Module File
_generate_module_nodejs(dr_ped
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dr_ped
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(dr_ped_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(dr_ped_generate_messages dr_ped_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg" NAME_WE)
add_dependencies(dr_ped_generate_messages_nodejs _dr_ped_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dr_ped_gennodejs)
add_dependencies(dr_ped_gennodejs dr_ped_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dr_ped_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(dr_ped
  "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dr_ped
)

### Generating Services

### Generating Module File
_generate_module_py(dr_ped
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dr_ped
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(dr_ped_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(dr_ped_generate_messages dr_ped_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dennis/progetto_labiagi/ws/src/dr_ped/msg/Obiettivo.msg" NAME_WE)
add_dependencies(dr_ped_generate_messages_py _dr_ped_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dr_ped_genpy)
add_dependencies(dr_ped_genpy dr_ped_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dr_ped_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dr_ped)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dr_ped
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(dr_ped_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(dr_ped_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dr_ped)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dr_ped
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(dr_ped_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(dr_ped_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dr_ped)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dr_ped
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(dr_ped_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(dr_ped_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dr_ped)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dr_ped
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(dr_ped_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(dr_ped_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dr_ped)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dr_ped\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dr_ped
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(dr_ped_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(dr_ped_generate_messages_py geometry_msgs_generate_messages_py)
endif()
