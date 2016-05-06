#include "core/core.h"
#include "core/interfaces.h"
#include "core/devices.h"
#include "core/semihosting.h"

// Cycle time in microseconds
#define CYCLE_TIME 1000

static size_t i = 0;

void core_setup()
{
    // Start clock
    clock.start();

    // Setup on-board peripherals
    core_board_setup();

    // Reset loop counter
    i = 0;
    
    if(false /* condition to enable semi hosting */) {
        // Note: Semihosting can only be enabled if a debugger is attached
        // If semihosting is active and no debugger is attached, the controller
        // will freeze here and block forever!
        setup_semihosting();
        DEBUG_PRINT("foo %u\n", i);
    }
}

void core_loop()
{
    // Increase loop counter
    i++;

    // Loop iteration start time
    Interface::Clock::Time startTime = clock.now();

    // TODO: INSERT YOUR CODE HERE

    // Receive USB
    usb.receive();

    // Delay until next release point is reached
    auto delta = clock.since(startTime);
    if(delta < CYCLE_TIME)
    {
        clock.delay(CYCLE_TIME-delta);
    }
}

void core_usb_callback(uint8_t* buffer, uint32_t length)
{
    // TODO: Handle data here
}

void core_board_setup()
{
    // Init LEDs
    red.init();
    green.init();
    blue.init();
    orange.init();
    
    // Init ADC
    adc.start();
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{

}

void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef* hadc)
{

}
