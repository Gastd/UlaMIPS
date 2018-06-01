library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.Types.all;

entity ula is
    generic (WSIZE : natural := 32);
    port(   opcode:  in ULA_OP;
            A, B: in  std_logic_vector(WSIZE-1 downto 0);
            Z: out std_logic_vector(WSIZE-1 downto 0);
            ovfl: out std_logic;
            zero: out std_logic );
end ula;

architecture behavioral of ula is
	signal tmp : std_logic_vector(WSIZE-1 downto 0);
	signal result : std_logic_vector(WSIZE-1 downto 0);
begin
    tmp <= A - B;
    Z <= result;
    proc_ula: process (A, B, opcode, result, tmp) is
    begin
        ovfl <= '0';
        if (result = X"00000000") then zero <= '1'; else zero <= '0'; end if;
        case opcode is
            when  AND_OP =>
                result <= A and B; -- and
            when  OR_OP =>
                result <= A or B; -- or
            when  ADD_OP =>
                result <= A + B; -- add with overflow
                ovfl <= (A(31) xnor B(31)) and (A(31) xor result(31));
            when  ADDU_OP =>
                result <= A + B; -- addu w/o overflow
            when  SUB_OP =>
                result <= tmp; -- sub with overflow
                ovfl <= (B(31) and result(31));
            when  SUBU_OP =>
                result <= tmp; -- subu w/o overflow
            when  SLT_OP =>
                result <= (0 => tmp(31), others => '0'); -- slt
            when  SLTU_OP =>
                if (unsigned(A) < unsigned(B))
                    then result <= X"00000001"; -- sltu
                    else result <= X"00000000";
                end if;
            when  NOR_OP =>
                result <= A nor B; -- nor
            when  XOR_OP =>
                result <= A xor B; -- xor
            when  SLL_OP =>
                result <= std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(A)))); -- sll
            when  SRL_OP =>
                result <= std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(A)))); -- srl
            when  SRA_OP =>
                result <= std_logic_vector(shift_right(signed(B), to_integer(unsigned(A)))); -- sra
            when  RTR_OP =>
                result <= std_logic_vector(rotate_right(unsigned(B), to_integer(unsigned(A)))); -- rtr
            when  RTL_OP =>
                result <= std_logic_vector(rotate_left(unsigned(B), to_integer(unsigned(A)))); -- rtl
            when others  =>
                result <= (others => '0');
        end case;
    end process;
end architecture behavioral;
