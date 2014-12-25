# - Find JSONCpp
# Find the JSONCpp includes and library
# This module defines
#  JSONCPP_INCLUDE_DIR, where to find json.h, etc.
#  JSONCPP_LIBRARIES, the libraries needed to use jsoncpp.

# adapted from http://code.google.com/p/emeraldviewer/

find_path(JSONCPP_INCLUDE_DIR
          NAMES json.h
          PATHS "/usr/local/include" "/usr/include" "/usr/local/Cellar" "/usr/local/opt"
          PATH_SUFFIXES jsoncpp json)

# post-process inlude path
if(JSONCPP_INCLUDE_DIR)
    string(REGEX REPLACE "/json.*$$" "" JSONCPP_INCLUDE_DIR ${JSONCPP_INCLUDE_DIR})
    set(JSONCPP_INCLUDE_DIR ${JSONCPP_INCLUDE_DIR} CACHE PATH "JsonCpp include dir" FORCE)
endif()

# get the GCC compiler version
exec_program(${CMAKE_CXX_COMPILER}
             ARGS ${CMAKE_CXX_COMPILER_ARG1} -dumpversion
             OUTPUT_VARIABLE _gcc_COMPILER_VERSION
             OUTPUT_STRIP_TRAILING_WHITESPACE)

set(JSONCPP_NAMES ${JSONCPP_NAMES} libjson_linux-gcc-${_gcc_COMPILER_VERSION}_libmt.so libjsoncpp*)
find_library(JSONCPP_LIBRARIES
             jsoncpp ${JSONCPP_INCLUDE_DIR})

find_package_handle_standard_args(JsonCpp DEFAULT_MSG JSONCPP_LIBRARIES JSONCPP_INCLUDE_DIR)

mark_as_advanced(JSONCPP_LIBRARIES JSONCPP_INCLUDE_DIR)