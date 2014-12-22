 #
 # Try to find libpq
 #
 # Once done this will define
 #  LIBPQ_FOUND          - TRUE if libpq found
 #  LIBPQ_INCLUDE_DIRS   - Where to find libpq include sub-directory
 #  LIBPQ_LIBRARIES_DIRS - Where to find libpq library sub-directory
 #  LIBPQ_LIBRARIES      - List of libraries when using libpq
 #

 # check cache
 if(LIBPQ_INCLUDE_DIRS)
   set(LIBPQ_INCLUDE_DIRS TRUE)
 endif(LIBPQ_INCLUDE_DIRS)

 find_program(PG_CONFIG_EXECUTABLE NAMES pg_config
 	DOC "pg_config - retrieve information about the installed version of PostgreSQL")

 include(FindPackageHandleStandardArgs)

 find_package_handle_standard_args(LibPQ DEFAULT_MSG PG_CONFIG_EXECUTABLE)

 if(PG_CONFIG_EXECUTABLE)
 	execute_process(
 		COMMAND ${PG_CONFIG_EXECUTABLE} "--includedir"
 		OUTPUT_VARIABLE LIBPQ_INCLUDE_DIRS)
 	string(REGEX REPLACE "[\r\n]" " " LIBPQ_INCLUDE_DIRS ${LIBPQ_INCLUDE_DIRS})
 	string(REGEX REPLACE " +$" "" LIBPQ_INCLUDE_DIRS ${LIBPQ_INCLUDE_DIRS})

 	execute_process(
 		COMMAND ${PG_CONFIG_EXECUTABLE} "--libdir"
 		OUTPUT_VARIABLE LIBPQ_LIBRARIES_DIRS)
 	string(REGEX REPLACE "[\r\n]" " " LIBPQ_LIBRARIES_DIRS ${LIBPQ_LIBRARIES_DIRS})
 	string(REGEX REPLACE " +$" "" LIBPQ_LIBRARIES_DIRS ${LIBPQ_LIBRARIES_DIRS})

 	find_library(LIBPQ_LIBRARY pq ${LIBPQ_LIBRARIES_DIRS})

   	set(LIBPQ_LIBRARIES ${LIBPQ_LIBRARY})

 	find_package_handle_standard_args(LibPQ DEFAULT_MSG LIBPQ_LIBRARIES_DIRS LIBPQ_LIBRARIES LIBPQ_INCLUDE_DIRS)
 else(PG_CONFIG_EXECUTABLE)
 	message(SEND_ERROR "pg_config not found. Do you have PostgreSQL development package installed?")
 endif(PG_CONFIG_EXECUTABLE)

 # mark cache
 mark_as_advanced(LIBPQ_LIBRARIES_DIRS LIBPQ_LIBRARIES LIBPQ_INCLUDE_DIRS)