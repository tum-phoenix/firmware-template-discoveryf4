#pragma once

#include "device/led.hpp"
#include "device/servo.hpp"
#include "device/esc.hpp"
#include "device/serial.hpp"

extern Device::Led red;
extern Device::Led green;
extern Device::Led blue;
extern Device::Led orange;

extern Device::Servo servo[2];

extern Device::ESC esc[4];

extern Device::Serial<1000> serial;
