cmake_minimum_required(VERSION 2.8)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake; ${CMAKE_MODULE_PATH}")

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_CROSSCOMPILING TRUE)

set(TARGET_SUPPORTS_SHARED_LIBS OFF)

include(CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER  ( arm-none-eabi-gcc GNU )
CMAKE_FORCE_CXX_COMPILER( arm-none-eabi-g++ GNU )

set(CMAKE_EXECUTABLE_SUFFIX_C   ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")

# Options
option(SEMIHOSTING "Enable ARM Semihosting" OFF)

# Project
project(DiscoveryF4 C CXX ASM)

# Set Device Identifier and Linker script
set(DEVICE                  "F407xx")
set(DEVICE_FAMILY           "F4")
set(DEVICE_CPU              "cortex-m4")
set(DEVICE_FLOAT_ABI        "hard")
set(DEVICE_FPU              "fpv4-sp-d16")
set(LINKER_SCRIPT           "${CMAKE_CURRENT_SOURCE_DIR}/STM32F407VGTx_FLASH.ld")
if(SEMIHOSTING)
    set(STM_SPECS   "rdimon")
else()
    set(STM_SPECS   "nosys")
endif()

# Set Compile and Linker flags
set(STM_CPU_FLAGS           "-mthumb -mcpu=${DEVICE_CPU}")
if(NOT "${DEVICE_FPU}X" STREQUAL "X")
    set(STM_CPU_FLAGS "${STM_CPU_FLAGS} -mfloat-abi=${DEVICE_FLOAT_ABI} -mfpu=${DEVICE_FPU}")
endif()
set(STM_COMPILE_FLAGS       "${STM_CPU_FLAGS} -g -fno-common -fmessage-length=0 -Wall -fno-exceptions -ffunction-sections -fdata-sections -MMD -MP")
set(STM_LINK_FLAGS          "${STM_CPU_FLAGS} -Wl,--gc-sections --specs=${STM_SPECS}.specs -Wl,-Map=${PROJECT_NAME}.map,--cref -T\"${LINKER_SCRIPT}\"")

set(COMMON_FLAGS            "-Os ${STM_COMPILE_FLAGS}")
set(CMAKE_C_FLAGS           "-std=gnu11 ${COMMON_FLAGS}")
set(CMAKE_CXX_FLAGS         "-std=gnu++11 ${COMMON_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS  ${STM_LINK_FLAGS})

# Set defines
add_definitions("-DSTM32${DEVICE}")
if(SEMIHOSTING)
    message(STATUS "Enabling ARM Semihosting")
    add_definitions("-DSEMIHOSTING")
else()
    message(STATUS "ARM Semihosting is DISABLED")
endif()

# Drivers and Middlewares
find_package(CMSIS      COMPONENTS ${DEVICE_FAMILY} REQUIRED)
find_package(STM_HAL    COMPONENTS ${DEVICE_FAMILY} REQUIRED)
find_package(USBDevice  COMPONENTS CDC REQUIRED)

# Project sources
FILE(GLOB_RECURSE SRC Src/*.c Src/*.cpp Inc/*.h )
FILE(GLOB_RECURSE CORE_SRC Core/src/*.c Core/src/*.cpp Core/include/*.h Core/include/*.hpp )
FILE(GLOB_RECURSE FRAMEWORK_SRC Framework/src/*.c Framework/src/*.cpp Framework/include/*.h Framework/include/*.hpp )

# Includes
include_directories(
    Inc
    Core/include
    Framework/include
    ${CMSIS_INCLUDES}
    ${STM_HAL_INCLUDES}
    ${USBDevice_INCLUDES}
)

# Add Target
add_executable( ${PROJECT_NAME}
    ${SRC}
    ${CORE_SRC}
    ${FRAMEWORK_SRC}
    ${CMSIS_SOURCES}
    ${STM_HAL_SOURCES}
    ${USBDevice_SOURCES}
)

if(SEMIHOSTING)
    target_link_libraries(${PROJECT_NAME} c rdimon)
endif()

# Generate Binaries from elf
add_custom_command( TARGET ${PROJECT_NAME}
                    POST_BUILD
                    COMMAND arm-none-eabi-objcopy ARGS -O ihex   $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_NAME}.hex
                    COMMAND arm-none-eabi-objcopy ARGS -O binary $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_NAME}.bin
                    COMMAND arm-none-eabi-objdump ARGS -St $<TARGET_FILE:${PROJECT_NAME}> > ${PROJECT_NAME}.lst
                    COMMAND arm-none-eabi-size ARGS $<TARGET_FILE:${PROJECT_NAME}>
                )
