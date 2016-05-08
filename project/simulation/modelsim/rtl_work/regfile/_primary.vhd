library verilog;
use verilog.vl_types.all;
entity regfile is
    port(
        reg1            : in     vl_logic_vector(4 downto 0);
        reg2            : in     vl_logic_vector(4 downto 0);
        regDisplay      : in     vl_logic_vector(4 downto 0);
        out1            : out    vl_logic_vector(31 downto 0);
        out2            : out    vl_logic_vector(31 downto 0);
        outDisplay      : out    vl_logic_vector(31 downto 0);
        data            : in     vl_logic_vector(31 downto 0);
        reg_wr          : in     vl_logic_vector(4 downto 0);
        wr_enable       : in     vl_logic;
        rst             : in     vl_logic
    );
end regfile;
