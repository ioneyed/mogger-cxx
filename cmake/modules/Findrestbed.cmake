# Copyright (c) 2013, 2014 Corvusoft

find_path( restbed_INCLUDE restbed HINTS "${CMAKE_SOURCE_DIR}/dependency/restbed/distribution/include" "/usr/include" "/usr/local/include" "/opt/local/include" )
find_library( restbed_LIBRARY NAMES restbed HINTS "${CMAKE_SOURCE_DIR}/dependency/restbed/distribution/library" "/usr/lib" "/usr/local/lib" "/opt/local/lib" )

if ( restbed_INCLUDE AND restbed_LIBRARY )
    set( FRAMEWORK_FOUND TRUE )

    if ( NOT FRAMEWORK_FIND_QUIETLY )
        message( STATUS "Found restbed header: ${restbed_INCLUDE}" )
        message( STATUS "Found restbed library: ${restbed_LIBRARY}" )
    endif ( )
else ( )
    if ( FRAMEWORK_FIND_REQUIRED )
        message( FATAL_ERROR "Failed to locate restbed!" )
    endif ( )
endif ( )
