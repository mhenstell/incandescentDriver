#include <ShiftPWM.h>   // include ShiftPWM.h after setting the pins!

#define LED_CONFIG	(DDRD |= (1<<6))
#define LED_ON		(PORTD |= (1<<6))
#define LED_OFF		(PORTD &= ~(1<<6))
#define CPU_PRESCALE(n) (CLKPR = 0x80, CLKPR = (n))
#define CDC_RX_ENDPOINT		3

int packetNum = 0;
int numRegisters = 37;

unsigned char maxBrightness = 255;
unsigned char pwmFrequency = 75;

const int ShiftPWM_latchPin=8;
// If your LED's turn on if the pin is low, set this to true, otherwise set it to false.
const bool ShiftPWM_invertOutputs = false;

// You can enable the option below to shift the PWM phase of each shift register by 8 compared to the previous.
// This will slightly increase the interrupt load, but will prevent all PWM signals from becoming high at the same time.
// This will be a bit easier on your power supply, because the current peaks are distributed.
const bool ShiftPWM_balanceLoad = false;

void setup()
{

  Serial.begin(9600);

  // Sets the number of 8-bit registers that are used.
  ShiftPWM.SetAmountOfRegisters(numRegisters);
  ShiftPWM.Start(pwmFrequency,maxBrightness);

}

void loop()
{

  LED_CONFIG;
  CPU_PRESCALE(0);

  while (1)
  {
    const int8_t n = Serial.available();
    if (n <= 0) {
      LED_OFF;
      continue;
    }

    if (n == 51) packetNum = 0;
    else if (n == 49) packetNum = 1;
    else if (n == 48) packetNum = 2;

    int offset = 0;
    if (packetNum == 0) offset = 0;
    else if (packetNum == 1) offset = 51;
    else if (packetNum == 2) offset = 100;

    const uint8_t irq_flags = SREG;
    cli();

    int8_t i;
    for (i = 0 ; i < n ; i++)
    {
      UENUM = CDC_RX_ENDPOINT;
      const uint8_t c = UEDATX;
      ShiftPWM.SetOne(offset + i, c);
    }

    // Release the USB buffer
    UEINTX = 0x6B;

    // Re-enabled interrupts
    SREG = irq_flags;
  }
}


