#include "core/interfaces.h"

using namespace Interface;

Clock clock(htim5, TIM_CHANNEL_1);

GPIO button( BUTTON_GPIO_Port, BUTTON_Pin );

GPIO gpio_out[] = {
    GPIO(GPIO_OUT_1_GPIO_Port, GPIO_OUT_1_Pin),
    GPIO(GPIO_OUT_2_GPIO_Port, GPIO_OUT_2_Pin),
};
GPIO gpio_in[] = {
    GPIO(GPIO_IN_1_GPIO_Port, GPIO_IN_1_Pin),
    GPIO(GPIO_IN_2_GPIO_Port, GPIO_IN_2_Pin),
};

// USB CDC interface
USB usb(clock);

// STM Discovery LEDs
GPIO led[ __LED_MAX__ ] = {
    GPIO( LED_RED_GPIO_Port, LED_RED_Pin ),
    GPIO( LED_GREEN_GPIO_Port, LED_GREEN_Pin ),
    GPIO( LED_BLUE_GPIO_Port, LED_BLUE_Pin ),
    GPIO( LED_ORANGE_GPIO_Port, LED_ORANGE_Pin ),
};

// SPI
GPIO spi_ss( SPI_SS_GPIO_Port, SPI_SS_Pin );
SPI spi(hspi2, &spi_ss );

// I2C
I2C i2c(hi2c1, 0x00 /* device addr*/, nullptr, nullptr, nullptr, I2C_MEMADD_SIZE_8BIT);

// UART
UART uart( huart3 );

// ADC
ADConverter adc( hadc1, 3, 3000 );

// ADC Channels
ADConverter::Channel adc_ch[] = {
    ADConverter::Channel(adc, 0),
    ADConverter::Channel(adc, 1),
    ADConverter::Channel(adc, 2),
};

// PWM
PWM pwm1[] = {
    PWM(htim1, TIM_CHANNEL_1),
    PWM(htim1, TIM_CHANNEL_2),
    PWM(htim1, TIM_CHANNEL_3),
    PWM(htim1, TIM_CHANNEL_4)
};
PWM pwm3[] = {
    PWM(htim3, TIM_CHANNEL_3),
    PWM(htim3, TIM_CHANNEL_4)
};
