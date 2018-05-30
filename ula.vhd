library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.Types.all;

entity ula is
    generic (WSIZE : natural := 32);
    port(   aluctl:  in ULA_OP;
            A, B: in  std_logic_vector(WSIZE-1 downto 0);
            Z: out std_logic_vector(WSIZE-1 downto 0);
            ovfl: out std_logic;
            zero: out std_logic );
end ula;

architecture behavioral of ula is
	signal tmp : std_logic_vector(WSIZE-1 downto 0);
	signal tmp2: std_logic_vector(WSIZE-1 downto 0);
	signal result : std_logic_vector(WSIZE-1 downto 0);
begin
    tmp <= A - B;
    tmp2 <= std_logic_vector(unsigned(A) - unsigned(B));
    Z <= result;
    proc_ula: process (A, B, aluctl, result, tmp, tmp2) is
        variable shift : integer;
    begin
        if (result = X"00000000") then zero <= '1'; else zero <= '0'; end if;
        ovfl <= '0';
        case aluctl is
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
                result <= (0 => tmp2(31), others => '0'); -- sltu
            when  NOR_OP =>
                result <= A nor B; -- nor
            when  XOR_OP =>
                result <= A xor B; -- xor
            when  SLL_OP =>
                shift := to_integer(unsigned(B));
                shift := to_integer(shift_left(to_unsigned(shift, 32), to_integer(unsigned(A)))); -- sll
                result <= std_logic_vector(to_unsigned(shift, 32));
            when  SRL_OP =>
                shift := to_integer(unsigned(B));
                shift := to_integer(shift_right(to_unsigned(shift, 32), to_integer(unsigned(A)))); -- srl
                result <= std_logic_vector(to_unsigned(shift, 32));
            when  SRA_OP =>
                shift := to_integer(unsigned(B));
                shift := to_integer(shift_right(to_signed(shift, 32), to_integer(unsigned(A)))); -- sra
                result <= std_logic_vector(to_signed(shift, 32));
            when  RTR_OP =>
                shift := to_integer(unsigned(B));
                shift := to_integer(rotate_right(to_signed(shift, 32), to_integer(unsigned(A)))); -- rtr
                result <= std_logic_vector(to_signed(shift, 32));
            when  RTL_OP =>
                shift := to_integer(unsigned(B));
                shift := to_integer(rotate_left(to_signed(shift, 32), to_integer(unsigned(A)))); -- rtl
                result <= std_logic_vector(to_signed(shift, 32));
            when others  =>
                result <= (others => '0');
        end case;
    end process;
end architecture behavioral;
