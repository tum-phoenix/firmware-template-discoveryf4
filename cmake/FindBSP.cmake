find_path(BSP_PATH
    "Common/io.h"
    PATHS ${CMAKE_CURRENT_SOURCE_DIR}
    PATH_SUFFIXES "Drivers/BSP/Components"
)

if(BSP_PATH)

    # Exports
    set(BSP_FOUND TRUE)
    set(BSP_SOURCES "")
    set(BSP_INCLUDES "${BSP_PATH}/Common")
    
    foreach( component ${BSP_FIND_COMPONENTS} )
        
        string( TOLOWER ${component} _component )
        
        set( BSP_COMPONENT_INCLUDE_VAR "BSP_COMPONENT_INCLUDE_${_component}" )
        find_path( ${BSP_COMPONENT_INCLUDE_VAR} ${_component}.h ${BSP_PATH}/${_component} )
        if(${BSP_COMPONENT_INCLUDE_VAR})
            set(BSP_INCLUDES ${BSP_INCLUDES} ${${BSP_COMPONENT_INCLUDE_VAR}})
        endif()
        
        set( BSP_COMPONENT_SOURCE_VAR "BSP_COMPONENT_SOURCE_${_component}" )
        find_file( ${BSP_COMPONENT_SOURCE_VAR} ${_component}.c ${BSP_PATH}/${_component} )
        if(${BSP_COMPONENT_SOURCE_VAR})
            set(BSP_SOURCES ${BSP_SOURCES} ${${BSP_COMPONENT_SOURCE_VAR}})
        endif()
    endforeach()
    
    include(FindPackageMessage)
    FIND_PACKAGE_MESSAGE(BSP "Found BSP: ${BSP_PATH}"
      "[${BSP_SOURCES}][${BSP_INCLUDES}]")
else()
    set(BSP_FOUND FALSE)
    if (BSP_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find BSP")
    endif ()
endif()

mark_as_advanced(
    BSP_FOUND
    BSP_SOURCES
    BSP_INCLUDES
)
