LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY robot IS
    PORT (
        fpgaclk : IN std_logic;
        echo : IN std_logic;
        trigger : OUT std_logic;
        led : OUT std_logic;
        Motor_L_pwm, Motor_L_in_1,Motor_L_in_2 : OUT std_logic;
        Motor_R_pwm, Motor_R_in_3,Motor_R_in_4 : OUT std_logic);
         
END ENTITY;

ARCHITECTURE behaviour OF robot IS
    
    COMPONENT pwm IS
        --generic(N : integer:=7);
        PORT (
            CLOCK_50 : IN std_logic;
            duty : IN std_logic_vector(15 DOWNTO 0);
            pwm : OUT std_logic);
    END COMPONENT;
    
    
   COMPONENT ultrasonic IS
        PORT (
            fpgaclk : IN std_logic;
            pulse : IN std_logic; -- echo
            triggerOut : OUT std_logic; -- trigger out
            obstacle : OUT std_logic);
        END COMPONENT;
    
    SIGNAL ultrasonic_sg : std_logic;
    SIGNAL pwm_1, pwm_2 : std_logic;
    SIGNAL forward, backward, turn_left, turn_right : std_logic;
    SIGNAL duty_1, duty_2 : std_logic_vector(15 DOWNTO 0);

BEGIN
    PWM1 : pwm PORT MAP(fpgaclk, duty_1, pwm_1); -- generate pwm for the motors
    PWM2 : pwm PORT MAP(fpgaclk, duty_2, pwm_2);

 -- motion control selection of the motor --
    PROCESS (forward, backward, turn_left, turn_right)
    BEGIN
        IF (forward = '1') THEN
            -- Motor left fwd 
            motor_L_pwm <= pwm_2;
            motor_L_in_1 <= '0';
            motor_L_in_2 <= '1';

            -- Motor right fwd 
            motor_R_pwm <= pwm_1;
            motor_R_in_3 <= '0';
            motor_R_in_4 <= '1';
            
            
        ELSIF (backward = '1') THEN
           -- Motor left back 
            motor_L_pwm <= pwm_1;
            motor_L_in_1 <= '1';
            motor_L_in_2 <= '0';

            -- Motor right back 
            motor_R_pwm <= pwm_2;
            motor_R_in_3 <= '1';
            motor_R_in_4 <= '0';            
            
            
        ELSIF (turn_right = '1') THEN
 
            -- Motor left fwd 
            motor_L_pwm <= pwm_2;
            motor_L_in_1 <= '0';
            motor_L_in_2 <= '1';
            
            -- Motor right back 
            motor_R_pwm <= pwm_1;
            motor_R_in_3 <= '1';
            motor_R_in_4 <= '0';               
                       
            
        ELSIF (turn_left = '1') THEN

            
       -- Motor left back 
            motor_L_pwm <= pwm_1;
            motor_L_in_1 <= '1';
            motor_L_in_2 <= '0';            
            
            -- Motor right fwd 
            motor_R_pwm <= pwm_2;
            motor_R_in_3 <= '0';
            motor_R_in_4 <= '1';            
            
        END IF;
    END PROCESS;
      
    ultrasonic_Middle : ultrasonic PORT MAP(fpgaclk => fpgaclk, pulse => echo, triggerOut => trigger, obstacle => ultrasonic_sg);
    PROCESS (ultrasonic_sg)
    BEGIN
        IF ultrasonic_sg = '1' THEN
                   led <= '1'; -- obstacle LED ON
                --turn left to avoid obstacle
                forward <= '0';
                backward <= '0';
                turn_right <= '0';
                turn_left <= '1';
                duty_1 <= X"0061"; --X"00C3"
                duty_2 <= X"0061";--X"00C3"

        ELSE
                 led <= '0'; -- turn off the LED 
                 
                 --move forward 
                 forward <= '1';
                backward <= '0';
                turn_right <= '0';
                turn_left <= '0';
                duty_1 <= X"0061";--X"00BE"
                duty_2 <= X"0061";--X"00C3"

        END IF;
    END PROCESS;

END ARCHITECTURE;