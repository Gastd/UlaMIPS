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
use work.Types.all;

ENTITY ula_tb IS
END ula_tb;
ARCHITECTURE ula_arch OF ula_tb IS
-- constants                                                 
-- signals                                                   
SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL opcode : ULA_OP;
SIGNAL Z : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL zero : STD_LOGIC;
SIGNAL ovfl : STD_LOGIC;
COMPONENT ula
    PORT (
    A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    opcode : IN ULA_OP;
    Z : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    zero : OUT STD_LOGIC;
    ovfl : OUT STD_LOGIC
    );
END COMPONENT;
BEGIN
    i1 : ula
    PORT MAP (
-- list connections between master ports and signals
    A => A,
    opcode => opcode,
    Z => Z,
    B => B,
    zero => zero,
    ovfl => ovfl
    );
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once           
    -- and
    opcode <=  AND_OP; A <= X"0000000F"; B <= X"00000003";
    wait for 10 ps;
    -- or
    opcode <=   OR_OP; A <= X"0000000C"; B <= X"00000003";
    wait for 10 ps;
    -- add: result = 0
    opcode <=  ADD_OP; A <= X"00000004"; B <= X"FFFFFFFC";
    wait for 10 ps;
    -- add: result = overflow
    opcode <=  ADD_OP; A <= X"7FFFFFFF"; B <= X"7FFFFFFF";
    wait for 10 ps;
    -- add: result = postivo
    opcode <=  ADD_OP; A <= X"00000004"; B <= X"00000010";
    wait for 10 ps;
    -- add: result = negativo
    opcode <=  ADD_OP; A <= X"FFFFFFF4"; B <= X"FFFFFFFA";
    wait for 10 ps;
    -- addu: result = 0
    opcode <= ADDU_OP; A <= X"00000004"; B <= X"FFFFFFFC";
    wait for 10 ps;
    -- addu: result = overflow
    opcode <= ADDU_OP; A <= X"7FFFFFFF"; B <= X"7FFFFFFF";
    wait for 10 ps;
    -- addu: result = postivo
    opcode <= ADDU_OP; A <= X"00000004"; B <= X"00000010";
    wait for 10 ps;
    -- addu: result = negativo
    opcode <= ADDU_OP; A <= X"FFFFFFF4"; B <= X"FFFFFFFA";
    wait for 10 ps;
    -- sub: zero
    opcode <=  SUB_OP; A <= X"00000004"; B <= X"00000004";
    wait for 10 ps;
    -- sub: overflow
    opcode <=  SUB_OP; A <= X"7FFFFFFF"; B <= X"FFFFFFFA";
    wait for 10 ps;
    -- sub: positivo
    opcode <=  SUB_OP; A <= X"FFFFFFFF"; B <= X"FFFFFFFA";
    wait for 10 ps;
    -- sub: negativo
    opcode <=  SUB_OP; A <= X"00000005"; B <= X"00000022";
    wait for 10 ps;
    -- subu: zero
    opcode <= SUBU_OP; A <= X"00000004"; B <= X"00000004";
    wait for 10 ps;
    -- subu: negativo
    opcode <= SUBU_OP; A <= X"00000004"; B <= X"00000010";
    wait for 10 ps;
    -- subu: positvo
    opcode <= SUBU_OP; A <= X"00000CAD"; B <= X"FFFFFF10";
    wait for 10 ps;
    -- subu: overflow
    opcode <= SUBU_OP; A <= X"7FFFFFFF"; B <= X"FFFFFFFA";
    wait for 10 ps;
    -- slt 1
    opcode <=  SLT_OP; A <= X"0000195D"; B <= X"0000618D";
    wait for 10 ps;
    -- slt 2
    opcode <=  SLT_OP; A <= X"00000002"; B <= X"00000001";
    wait for 10 ps;
    -- sltu 1
    opcode <= SLTU_OP; A <= X"0000195D"; B <= X"0000618D";
    wait for 10 ps;
    -- sltu 2
    opcode <= SLTU_OP; A <= X"FFFF9842"; B <= X"0FFF618D";
    wait for 10 ps;
    -- nor
    opcode <=  NOR_OP; A <= X"FF00FF00"; B <= X"FFFF0000";
    wait for 10 ps;
    -- xor
    opcode <=  XOR_OP; A <= X"0F0F0F0F"; B <= X"F0F0FFFF";
    wait for 10 ps;
    -- sll
    opcode <=  SLL_OP; A <= X"00000004"; B <= X"0000000F";
    wait for 10 ps;
    -- srl
    opcode <=  SRL_OP; A <= X"00000004"; B <= X"000000F0";
    wait for 10 ps;
    -- sra
    opcode <=  SRA_OP; A <= X"00000008"; B <= X"FFFFF000";
    wait for 10 ps;
    -- rtr
    opcode <=  RTR_OP; A <= X"00000004"; B <= X"0000000F";
    wait for 10 ps;
    -- rtl  
    opcode <=  RTL_OP; A <= X"00000008"; B <= X"000000F0";
    wait for 10 ps;
	 -- zero
	opcode <=  SUB_OP; A <= X"0000FFFF"; B <= X"0000FFFF";
	wait for 10 ps;
END PROCESS init;
END ula_arch;
