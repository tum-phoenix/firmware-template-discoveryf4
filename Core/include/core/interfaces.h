#pragma once

#include "interface/clock.hpp"
#include "interface/gpio.hpp"
#include "interface/usb.hpp"
#include "interface/i2c.hpp"
#include "interface/spi.hpp"
#include "interface/uart.hpp"
#include "interface/pwm.hpp"
#include "interface/adc.hpp"

enum {
    LED_RED = 0,
    LED_GREEN,
    LED_BLUE,
    LED_ORANGE,
    __LED_MAX__
};

// Global time base clock in microseconds
extern Interface::Clock clock;

// User Button
extern Interface::GPIO button;

// GPIO
extern Interface::GPIO gpio_out[2];
extern Interface::GPIO gpio_in[2];

// USB CDC interface
extern Interface::USB usb;

// STM Discovery LEDs
extern Interface::GPIO led[__LED_MAX__];

// PWMs
extern Interface::PWM pwm1[4]; // 4 channel PWM, 3ms cycle time
extern Interface::PWM pwm3[2]; // 2 channel PWM, 50ms cycle time

// ADC
extern Interface::ADConverter adc;
extern Interface::ADConverter::Channel adc_ch[3];

// SPI
extern Interface::SPI spi;
extern Interface::GPIO spi_ss;

// I2C
extern Interface::I2C i2c;

// UART
extern Interface::UART uart;


// TODO: CAN
// extern Interface::CAN can;
