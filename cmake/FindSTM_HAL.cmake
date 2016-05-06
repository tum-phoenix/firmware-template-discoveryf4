# Defines
# STM_HAL_FOUND
# STM_HAL_INCLUDES
# STM_HAL_SOURCES

set(STM_HAL_FOUND FALSE)
set(STM_HAL_INCLUDES "")
set(STM_HAL_SOURCES "")

foreach( component ${STM_HAL_FIND_COMPONENTS} )
    string( TOUPPER ${component} _COMPONENT )
    string( TOLOWER ${component} _component )
    
    find_path(STM_HAL_COMPONENT_PATH
        "Inc/stm32${_component}xx_hal.h"
        PATHS ${CMAKE_CURRENT_SOURCE_DIR}
        PATH_SUFFIXES "Drivers/STM32${_COMPONENT}xx_HAL_Driver"
    )
    
    if(STM_HAL_COMPONENT_PATH)
        set(STM_HAL_INCLUDES ${STM_HAL_INCLUDES} "${STM_HAL_COMPONENT_PATH}/Inc")
        
        file(GLOB STM_HAL_COMPONENT_SOURCES
            "${STM_HAL_COMPONENT_PATH}/Src/*.c"
        )
        
        set(STM_HAL_SOURCES ${STM_HAL_SOURCES} ${STM_HAL_COMPONENT_SOURCES})
    else()
        message(WARNING "Could not find STM HAL component ${_COMPONENT}")
    endif()
endforeach()


if(STM_HAL_INCLUDES)
    # Exports
    set(STM_HAL_FOUND TRUE)
    
    include(FindPackageMessage)
    FIND_PACKAGE_MESSAGE(STM_HAL "Found STM HAL: ${STM_HAL_COMPONENT_PATH}"
      "[${STM_HAL_SOURCES}][${STM_HAL_INCLUDES}]")
else()
    set(STM_HAL_FOUND FALSE)
    if (STM_HAL_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find STM HAL")
    endif ()
endif()

mark_as_advanced(
    STM_HAL_FOUND
    STM_HAL_INCLUDES
    STM_HAL_SOURCES
)
