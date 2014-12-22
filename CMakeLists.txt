cmake_minimum_required(VERSION 2.8.4)
project(main-cxx)

set ( CMAKE_VERBOSE_MAKEFILE true )
set( CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules" )

add_subdirectory( ${CMAKE_SOURCE_DIR}/dependency/restbed)
add_subdirectory( ${CMAKE_SOURCE_DIR}/dependency/restbed/dependency/framework)

#dependencies
find_package( LibPQXX REQUIRED )
find_package( LibPQ REQUIRED )
find_package( restbed REQUIRED )
find_package( framework REQUIRED )


include_directories(${LIBPQXX_INCLUDE_DIRS})
include_directories(${LIBPQ_INCLUDE_DIRS})
include_directories(${framework_INCLUDE})
include_directories(${restbed_INCLUDE})

link_directories(${LIBPQXX_LIBRARY_DIRS})
link_directories(${LIBPQ_LIBRARY_DIRS})
link_directories(${restbed_INCLUDE})
link_directories(${framework_INCLUDE})

#
# Configuration
#
set( INCLUDE_DIR "${CMAKE_SOURCE_DIR}" )
set( SOURCE_DIR "${INCLUDE_DIR}/source" )
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DASIO_STANDALONE=YES" )
set( CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/distribution" )
set( LIBRARY_OUTPUT_PATH "${CMAKE_INSTALL_PREFIX}/library" )

if ( ${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" )
    if ( ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 4.9 )
        message( FATAL_ERROR "\nGCC version < 4.9\nYour systems default compiler is GCC. This project makes use of c++11 features present only in versions of gcc >= 4.9. You can use a different compiler by re-running cmake with the command switch \"-D CMAKE_CXX_COMPILER=<compiler>\" " )
    endif ( )
elseif( ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang" )
    if ( ${CMAKE_CXX_COMPILER_VERSION} VERSION_LESS 3.3 )
        message( FATAL_ERROR "\nClang version < 3.3\nYour systems default compiler is clang. This project makes use of c++11 features present only in versions of clang >= 3.3. You can use a different compiler by re-running cmake with the command switch \"-D CMAKE_CXX_COMPILER=<compiler>\" " )
    else ( )
        set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++" )
    endif ( )
else ( )
    message( FATAL_ERROR "Compiler not supported")
endif ( )

if ( CMAKE_BUILD_TYPE MATCHES Debug )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g -O0 -Wall -Wextra -Weffc++ -pedantic" )
else ( )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Weffc++ -pedantic" )
endif ( )


set( EXECUTABLE_OUTPUT_PATH "${CMAKE_SOURCE_DIR}/distribution/bin/"  )

#
# Build
#
#include( "${CMAKE_SOURCE_DIR}/cmake/build_manifest.cmake" )

include_directories( ${INCLUDE_DIR} )

if ( BUILD_EXAMPLES )
    add_subdirectory( "${CMAKE_SOURCE_DIR}/example" "examples" )
endif ( )

#
# Install
#
file( MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/library" )
file( MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/include/main_cxx" )

#include( "${CMAKE_SOURCE_DIR}/cmake/build_artifacts.cmake" )

#install( FILES ${INCLUDE_DIR}/restbed DESTINATION "include/" )
#install( FILES ${INCLUDE_DIR}/framework DESTINATION "include/" )

#install( FILES ${FRAMEWORK_ARTIFACTS} DESTINATION "include/mogger_cxx/" )


set(SOURCE_FILES ${SOURCE_DIR}/main.cpp)
add_executable(main-bin ${SOURCE_FILES})
#${RESTBED_LIBRARY} ${FRAMEWORK_LIBRARY}
target_link_libraries(main-bin ${LIBPQXX_LIBRARY} ${LIBPQ_LIBRARY} ${restbed_LIBRARY} ${framework_LIBRARY} )
