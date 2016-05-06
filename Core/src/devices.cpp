#include "core/devices.h"
#include "core/interfaces.h"

using namespace Device;

// Board LEDs
Led red( led[LED_RED], clock );
Led green( led[LED_GREEN], clock );
Led blue( led[LED_BLUE], clock );
Led orange( led[LED_ORANGE], clock );

ESC esc[] = {
    ESC(pwm1[0]),
    ESC(pwm1[1]),
    ESC(pwm1[2]),
    ESC(pwm1[3])
};

Servo servo[] = {
    Servo(pwm3[0], -10000, 10000),
    Servo(pwm3[1], -10000, 10000)
};

Serial<1000> serial(uart);
