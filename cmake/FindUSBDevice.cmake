# Defines
# USBDevice_FOUND
# USBDevice_INCLUDES
# USBDevice_SOURCES

find_path(USBDevice_PATH
    "Core/Inc/usbd_core.h"
    PATHS ${CMAKE_CURRENT_SOURCE_DIR}
    PATH_SUFFIXES "Middlewares/ST/STM32_USB_Device_Library"
)

if(USBDevice_PATH)

    # USB Device Core
    find_path(USBDevice_CORE_PATH "Inc/usbd_core.h" PATHS ${USBDevice_PATH} PATH_SUFFIXES "Core")
    set(USBDevice_CORE_SOURCES          "${USBDevice_CORE_PATH}/Src/usbd_core.c"
                                        "${USBDevice_CORE_PATH}/Src/usbd_ctlreq.c"
                                        "${USBDevice_CORE_PATH}/Src/usbd_ioreq.c")
    
    # USB Device classes
    find_path(USBDevice_AUDIO_PATH      "Inc/usbd_audio.h"      PATHS ${USBDevice_PATH} PATH_SUFFIXES "Class/AUDIO"     )
    find_path(USBDevice_CDC_PATH        "Inc/usbd_cdc.h"        PATHS ${USBDevice_PATH} PATH_SUFFIXES "Class/CDC"       )
    find_path(USBDevice_CUSTOMHID_PATH  "Inc/usbd_customhid.h"  PATHS ${USBDevice_PATH} PATH_SUFFIXES "Class/CustomHID" )
    find_path(USBDevice_DFU_PATH        "Inc/usbd_dfu.h"        PATHS ${USBDevice_PATH} PATH_SUFFIXES "Class/DFU"       )
    find_path(USBDevice_HID_PATH        "Inc/usbd_hid.h"        PATHS ${USBDevice_PATH} PATH_SUFFIXES "Class/HID"       )
    find_path(USBDevice_MSC_PATH        "Inc/usbd_msc.h"        PATHS ${USBDevice_PATH} PATH_SUFFIXES "Class/MSC"       )
    
    set(USBDevice_AUDIO_SOURCES         "${USBDevice_AUDIO_PATH}/Src/usbd_audio.c"          )
    set(USBDevice_CDC_SOURCES           "${USBDevice_CDC_PATH}/Src/usbd_cdc.c"              )
    set(USBDevice_CUSTOMHID_SOURCES     "${USBDevice_CUSTOMHID_PATH}/Src/usbd_customhid.c"  )
    set(USBDevice_DFU_SOURCES           "${USBDevice_DFU_PATH}/Src/usbd_dfu.c"              )
    set(USBDevice_HID_SOURCES           "${USBDevice_HID_PATH}/Src/usbd_hid.c"              )
    set(USBDevice_MSC_SOURCES           "${USBDevice_MSC_PATH}/Src/usbd_msc.c"
                                        "${USBDevice_MSC_PATH}/Src/usbd_msc_bot.c"
                                        "${USBDevice_MSC_PATH}/Src/usbd_msc_data.c"
                                        "${USBDevice_MSC_PATH}/Src/usbd_msc_scsi.c"         )
    
    # Exports
    set(USBDevice_FOUND TRUE)
    set(USBDevice_SOURCES ${USBDevice_CORE_SOURCES} )
    set(USBDevice_INCLUDES ${USBDevice_CORE_PATH}/Inc )
    
    foreach( component ${USBDevice_FIND_COMPONENTS} )
        string( TOUPPER ${component} _COMPONENT )
        
        set(COMPONENT_VARNAME_PATH "USBDevice_${_COMPONENT}_PATH")
        set(COMPONENT_VARNAME_SOURCES "USBDevice_${_COMPONENT}_SOURCES")
        
        set(USBDevice_INCLUDES ${USBDevice_INCLUDES} ${${COMPONENT_VARNAME_PATH}}/Inc)
        set(USBDevice_SOURCES ${USBDevice_SOURCES} ${${COMPONENT_VARNAME_SOURCES}})
    endforeach()
    
    include(FindPackageMessage)
    FIND_PACKAGE_MESSAGE(USBDevice "Found USBDevice: ${USBDevice_PATH}"
      "[${USBDevice_SOURCES}][${USBDevice_INCLUDES}]")
else()
    set(USBDevice_FOUND FALSE)
    if (USBDevice_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find USBDevice")
    endif ()
endif()

mark_as_advanced(
    USBDevice_FOUND
    USBDevice_SOURCES
    USBDevice_INCLUDES
)
