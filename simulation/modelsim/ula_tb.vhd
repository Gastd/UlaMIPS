-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "05/24/2018 21:50:07"
                                                            
-- Vhdl Test Bench template for design  :  ula
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY ula_tb IS
END ula_tb;
ARCHITECTURE ula_arch OF ula_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL aluctl : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL aluout : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL zero : STD_LOGIC;
SIGNAL overflow : STD_LOGIC;
COMPONENT ula
    PORT (
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    aluctl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    aluout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    zero : OUT STD_LOGIC;
    overflow : OUT STD_LOGIC
    );
END COMPONENT;
BEGIN
    i1 : ula
    PORT MAP (
-- list connections between master ports and signals
    A => A,
    aluctl => aluctl,
    aluout => aluout,
    B => B,
    zero => zero,
    overflow => overflow
    );
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once           
    -- and
    aluctl <=  "0000"; A <= X"0000000F"; B <= X"00000003";
    wait for 10 ns;
    -- or
    aluctl <=  "0001"; A <= X"0000000C"; B <= X"0000003";
    wait for 10 ns;
    -- add
    aluctl <=  "0010"; A <= X"FFFFFFFF"; B <= X"0000000F";
    wait for 10 ns;
    -- addu
    aluctl <=  "0011"; A <= X"00000004"; B <= X"00000010";
    wait for 10 ns;
    -- sub
    aluctl <=  "0100"; A <= X"00000004"; B <= X"00000010";
    wait for 10 ns;
    -- subu
    aluctl <=  "0101"; A <= X"00000004"; B <= X"00000010";
    wait for 10 ns;
    -- slt 1
    aluctl <=  "0110"; A <= X"0000195D"; B <= X"0000618D";
    wait for 10 ns;
    -- slt 2
    aluctl <=  "0110"; A <= X"00000002"; B <= X"00000001";
    wait for 10 ns;
    -- sltu
    aluctl <=  "0111"; A <= X"0000195D"; B <= X"0000618D";
    wait for 10 ns;
    -- nor
    aluctl <=  "1000"; A <= X"FF00FF00"; B <= X"FFFF0000";
    wait for 10 ns;
    -- xor
    aluctl <=  "1001"; A <= X"0F0F0F0F"; B <= X"F0F0FFFF";
    wait for 10 ns;
    -- sll
    aluctl <=  "1010"; A <= X"0000000F"; B <= X"00000004";
    wait for 10 ns;
    -- srl
    aluctl <=  "1011"; A <= X"0000000F"; B <= X"00000004";
    wait for 10 ns;
    -- sra
    aluctl <=  "1100"; A <= X"0000000F"; B <= X"00000004";
    wait for 10 ns;
    -- rtr
    aluctl <=  "1101"; A <= X"0000000F"; B <= X"00000004";
    wait for 10 ns;
    -- rtl  
    aluctl <=  "1101"; A <= X"0000000F"; B <= X"00000004";
    wait for 10 ns;
END PROCESS init;
END ula_arch;
