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


architecture Behavioral of PwmGenerator is

	constant c_timer_limit : integer := c_clk_frequency / c_pwm_frequency; -- 1ms is the overall period for duty cycle period. For example: 40% will be on, %60 will be off. 
	
	signal high_time_limit : integer := 0;
	signal counter : integer range 0 to c_timer_limit := 0;

begin
	-- Define high time limit as a combinational.
	-- Whenever duty cycle changes, update high time limit.
	high_time_limit <= conv_integer(duty_cycle_i) * (c_timer_limit/100);
	
	P_PWM : process (clk_i) begin

		if (rising_edge(clk_i)) then 
			
			if (counter = c_timer_limit - 1) then 
				counter <= 0;
				pwm_signal_o <= '1';
			elsif (counter < high_time_limit - 1) then
				pwm_signal_o <= '1';
				counter <= counter + 1;
			else -- Greater than (high_time_limit - 1)
				pwm_signal_o <= '0';
				counter <= counter + 1;
			end if;
		
		end if;
		
	end process;
	
	
end architecture;
