#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

void core_setup();
void core_board_setup();
void core_loop();
void core_usb_callback(uint8_t* buffer, uint32_t length);

#ifdef __cplusplus
    }
#endif
