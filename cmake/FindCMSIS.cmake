# Defines
# CMSIS_FOUND
# CMSIS_INCLUDES
# CMSIS_SOURCES


find_path(CMSIS_PATH
    "Include/arm_math.h"
    PATHS ${CMAKE_CURRENT_SOURCE_DIR}
    PATH_SUFFIXES "Drivers/CMSIS"
)

if(CMSIS_PATH)
    # Exports
    set(CMSIS_FOUND TRUE)
    set(CMSIS_INCLUDES
        ${CMSIS_PATH}/Include
    )
    
    set(CMSIS_SOURCES "")
    
    if( CMSIS_FIND_COMPONENTS )
        foreach( component ${CMSIS_FIND_COMPONENTS} )
            string( TOUPPER ${component} _COMPONENT )
            string( TOLOWER ${component} _component )
            
            find_path(CMSIS_COMPONENT_PATH "Include/stm32${_component}xx.h" "${CMSIS_PATH}/Device/ST/STM32${_COMPONENT}xx" )
            if(CMSIS_COMPONENT_PATH)
                set(CMSIS_INCLUDES ${CMSIS_INCLUDES} "${CMSIS_COMPONENT_PATH}/Include")
                
                file(GLOB CMSIS_COMPONENT_SOURCES
                    "${CMSIS_COMPONENT_PATH}/Source/Templates/*.c"
                    "${CMSIS_COMPONENT_PATH}/Source/Templates/gcc/*.s"
                )
                
                set(CMSIS_SOURCES ${CMSIS_SOURCES} ${CMSIS_COMPONENT_SOURCES})
            else()
                message(WARNING "Could not find CMSIS component ${_COMPONENT}")
            endif()
        endforeach()
    endif()
    
    include(FindPackageMessage)
    FIND_PACKAGE_MESSAGE(CMSIS "Found CMSIS: ${CMSIS_PATH}"
      "[${CMSIS_SOURCES}][${CMSIS_INCLUDES}]")
else()
    set(CMSIS_FOUND FALSE)
    if (CMSIS_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find CMSIS")
    endif ()
endif()

mark_as_advanced(
    CMSIS_FOUND
    CMSIS_INCLUDES
    CMSIS_SOURCES
)
