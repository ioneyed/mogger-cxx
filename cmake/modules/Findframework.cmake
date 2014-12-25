# Copyright (c) 2013, 2014 Corvusoft

find_path( framework_INCLUDE framework HINTS "${CMAKE_SOURCE_DIR}/dependency/restbed/dependency/framework/distribution/mogger" "/usr/mogger" "/usr/local/mogger" "/opt/local/mogger" )
find_library( framework_LIBRARY NAMES framework HINTS "${CMAKE_SOURCE_DIR}/dependency/restbed/dependency/framework/distribution/library" "/usr/lib" "/usr/local/lib" "/opt/local/lib" )

if ( framework_INCLUDE AND framework_LIBRARY )
    set( FRAMEWORK_FOUND TRUE )

    if ( NOT FRAMEWORK_FIND_QUIETLY )
        message( STATUS "Found framework header: ${framework_INCLUDE}" )
        message( STATUS "Found framework library: ${framework_LIBRARY}" )
    endif ( )
else ( )
    if ( FRAMEWORK_FIND_REQUIRED )
        message( FATAL_ERROR "Failed to locate framework!" )
    endif ( )
endif ( )
