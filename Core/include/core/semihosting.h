#pragma once

extern void initialise_monitor_handles(void);

#ifdef SEMIHOSTING
  #define DEBUG_PRINT(...) printf(__VA_ARGS__)
#else
  #define DEBUG_PRINT(...)
#endif

void setup_semihosting()
{
#ifdef SEMIHOSTING
    initialise_monitor_handles();
#endif
}
