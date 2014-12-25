# Copyright (c) 2013, 2014 Corvusoft

find_path( restbed_INCLUDE restbed HINTS "${CMAKE_SOURCE_DIR}/dependency/restbed/distribution" "/usr/" "/usr/local/" "/opt/local/" )
find_library( restbed_LIBRARY NAMES restbed HINTS "${CMAKE_SOURCE_DIR}/dependency/restbed/distribution/library" "/usr/lib" "/usr/local/lib" "/opt/local/lib" )

if ( restbed_INCLUDE AND restbed_LIBRARY )
    set( RESTBED_FOUND TRUE )

    if ( NOT RESTBED_FIND_QUIETLY )
        message( STATUS "Found restbed header: ${restbed_INCLUDE}" )
        message( STATUS "Found restbed library: ${restbed_LIBRARY}" )
    endif ( )
else ( )
    if ( RESTBED_FIND_REQUIRED )
        message( FATAL_ERROR "Failed to locate restbed!" )
    endif ( )
endif ( )
