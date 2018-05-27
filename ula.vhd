library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ula is
    port(   aluctl:  in  std_logic_vector(3 downto 0);
            A, B: in  std_logic_vector(31 downto 0);
            aluout: out std_logic_vector(31 downto 0);
            overflow: out std_logic;
            zero: out std_logic );
end ula;

architecture behavioral of ula is
	signal tmp : std_logic_vector(31 downto 0);
	signal tmp2: std_logic_vector(31 downto 0);
	signal result : std_logic_vector(31 downto 0);
	signal count : std_logic_vector(31 downto 0);
begin
    tmp <= A - B;
    tmp2 <= std_logic_vector(unsigned(A) - unsigned(B));
    aluout <= result;
    proc_ula: process (A, B, aluctl, result, tmp, tmp2, count) begin
    count <= B;
    if (result = X"00000000") then zero <= '1'; else zero <= '0'; end if;
    overflow <= '0';
    case aluctl is
        when  "0000" =>
            result <= A and B; -- and
        when  "0001" =>
            result <= A or B; -- or
        when  "0010" =>
            result <= A + B; -- add com overflow
            overflow <= (A(31) xnor B(31)) and (A(31) xor result(31));
        when  "0011" =>
            result <= A + B; -- addu sem overflow
        when  "0100" =>
            result <= tmp; -- sub com overflow
            overflow <= (A(31) xnor B(31)) and (A(31) xor result(31));
        when  "0101" =>
            result <= tmp; -- subu sem overflow
        when  "0110" =>
            result <= (0 => tmp(31), others => '0'); -- slt
        when  "0111" =>
            result <= (0 => tmp2(31), others => '0'); -- sltu
        when  "1000" =>
            result <= A nor B; -- nor
        when  "1001" =>
            result <= A xor B; -- xor
        when  "1010" =>
            result <= A;
            FOR i IN 0 TO 31 LOOP
                result <= std_logic_vector(shift_left(unsigned(result), 1)); -- sll
                count <= count - '1';
                exit when count = X"00000000";
            END LOOP;
        when  "1011" =>
            result <= A;
            FOR i IN 0 TO 31 LOOP
                result <= std_logic_vector(shift_right(unsigned(result), 1)); -- srl
                count <= count - '1';
                exit when count = X"00000000";
            END LOOP;
        when  "1100" =>
            result <= A;
            FOR i IN 0 TO 31 LOOP
                result <= std_logic_vector(shift_right(unsigned(result), 1)); -- sra
                count <= count - '1';
                exit when count = X"00000000";
            END LOOP;
        when  "1101" =>
            result <= A;
            FOR i IN 0 TO 31 LOOP
                result <= std_logic_vector(rotate_right(unsigned(result), 1)); -- rtr
                count <= count - '1';
                exit when count = X"00000000";
            END LOOP;
        when  "1110" =>
            result <= A;
            FOR i IN 0 TO 31 LOOP
                result <= std_logic_vector(rotate_right(unsigned(result), 1)); -- rtl
                count <= count - '1';
                exit when count = X"00000000";
            END LOOP;
        when others  =>
            result <= (others => '0');
    end case;
end process;
end architecture behavioral;
