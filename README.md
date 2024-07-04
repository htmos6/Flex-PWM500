# PWM Generator

The PWM (Pulse Width Modulation) Generator is designed to create a PWM signal which can be used to control the brightness of LEDs or other devices requiring a PWM input. This particular module is highly configurable, allowing for changes in the clock frequency and the desired PWM frequency through generics. The duty cycle, which dictates the proportion of time the signal is high, is provided as an input and can be adjusted to vary the PWM output.

## Features
- **Configurable Clock Frequency:** The `c_clk_frequency` generic allows the user to set the clock frequency driving the module.
- **Adjustable PWM Frequency:** The `c_pwm_frequency` generic lets the user specify the PWM frequency. The default is set to 1 kHz, which is suitable for driving LEDs.
- **Duty Cycle Input:** The duty cycle is provided as a 7-bit input (`duty_cycle_i`), allowing values from 0 to 100, representing the percentage of the time the signal should be high.
- **PWM Output:** The module outputs a PWM signal (`pwm_signal_o`) based on the configured parameters and the provided duty cycle.

## Entity Declaration
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PwmGenerator is
    generic 
    (
        c_clk_frequency : integer := 100_000_000;
        c_pwm_frequency : integer := 1000 -- 1 Khz suggested to drive most of the leds for health reasons.
    );
    port 
    (
        clk_i : in std_logic;
        duty_cycle_i : in std_logic_vector(6 downto 0); -- Will hold numbers up to 100
        pwm_signal_o : out std_logic
    );
end entity;
```
## Architecture Description
The architecture Behavioral of the PWM Generator contains the following:

**Constants and Signals:**

**c_timer_limit:** Constant defining the limit of the timer based on the clock and PWM frequencies.  
**high_time_limit:** Signal defining the high time limit calculated from the duty cycle.  
**counter:** Signal acting as a counter to generate the PWM signal.  
**Process (P_PWM):** The process is sensitive to the rising edge of the clock.
It increments the counter and updates the PWM signal based on the counter value and the high time limit.
The PWM signal is set high if the counter is less than the high time limit, and low otherwise.

## Usage
To use the PWM Generator module:

### Instantiate the Module:
Define an instance of the `PwmGenerator` in your top-level design.
```vhdl
uut: entity work.PwmGenerator
  generic map (
    c_clk_frequency => 100_000_000, -- 100 MHz
    c_pwm_frequency => 1000        -- 1 kHz
  )
  port map (
    clk_i => clk,
    duty_cycle_i => duty_cycle,
    pwm_signal_o => pwm_out
  );
```

### Connect the Ports:
- **clk_i:** Connect to your system clock.
- **duty_cycle_i:** Provide a 7-bit input signal representing the desired duty cycle.
- **pwm_signal_o:** Connect the output to your load (e.g., LED).

### Adjust Parameters:
- Modify `c_clk_frequency` and `c_pwm_frequency` if needed.
- Provide appropriate values for `duty_cycle_i` to control the PWM output.

- **Timing of the PWM is adjusted precisely, starting at the 0th cycle.**

![image](https://github.com/htmos6/PWM-Generator/assets/88316097/80666042-32de-4139-a6f5-67830c4a8976)

![image](https://github.com/htmos6/PWM-Generator/assets/88316097/5f591043-e0fe-4687-9469-4705d23fd39c)

