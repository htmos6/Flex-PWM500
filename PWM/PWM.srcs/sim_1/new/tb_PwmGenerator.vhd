library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_PwmGenerator is
generic 
(
	C_clk_frequency : integer := 100_000;
	c_pwm_frequency : integer := 1000
);
end entity;


architecture Behavioral of tb_PwmGenerator is

	component PwmGenerator is
		generic 
		(
			c_clk_frequency : integer := 100_000_000;
			c_pwm_frequency : integer := 1000 -- 1 Khz suggested to drive most of the leds for health reasons. (1 ms)
		);
		port 
		(
			clk_i : in std_logic;
			duty_cycle_i : in std_logic_vector(6 downto 0); -- Will hold numbers up to 100
			pwm_signal_o : out std_logic
		);
	end component;
	
	
	constant c_clk_period : time := 1 sec / real(c_clk_frequency);
	
	signal clk_i : std_logic := '0';
	signal duty_cycle_i : std_logic_vector(6 downto 0) := (others => '0');
	signal pwm_signal_o : std_logic := '0';
 
begin

	uut : PwmGenerator
	generic map
	(
		c_clk_frequency => c_clk_frequency,
		c_pwm_frequency => c_pwm_frequency
	)
	port map 
	(
		clk_i => clk_i,
		duty_cycle_i => duty_cycle_i,
		pwm_signal_o => pwm_signal_o
	);
	
	
	P_CLK : process begin
		wait for c_clk_period / 2;
		clk_i <= '0';
		wait for c_clk_period / 2;
		clk_i <= '1';	
	end process;
	
	
	P_DUTY : process begin
		wait until rising_edge(clk_i);
			
		duty_cycle_i <= std_logic_vector(to_unsigned(10, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(20, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(30, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(40, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(50, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(60, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(70, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(80, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(90, duty_cycle_i'length));
		
		wait for 5 ms;
		
		duty_cycle_i <= std_logic_vector(to_unsigned(100, duty_cycle_i'length));


		report "TEST CASES COMPLETED SUCCESSFULLY" severity note;
		-- End simulation
		wait;
		
	end process;
end architecture;
