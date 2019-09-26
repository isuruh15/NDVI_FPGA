library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity home2_top is
    Port ( 
        rx : in STD_LOGIC;       -- ingresso per la ricezione seriale
        tx : out STD_LOGIC;      -- uscita per la trasmissione seriale
        rst : in STD_LOGIC;      -- ingresso di reset (attivo altro)
        clk : in STD_LOGIC;     -- ingresso di clock
        
        vga_hsync : out  STD_LOGIC;
       vga_vsync : out  STD_LOGIC;
       vga_r     : out  STD_LOGIC_vector(3 downto 0);
       vga_g     : out  STD_LOGIC_vector(3 downto 0);
       vga_b     : out  STD_LOGIC_vector(3 downto 0));
end home2_top;

architecture Behavioral of home2_top is

    -- AXI4Stream component declaration
    COMPONENT AXI4Stream_RS232_0
        PORT (
        clk_uart : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        RS232_TX : OUT STD_LOGIC;
        RS232_RX : IN STD_LOGIC;
        m00_axis_rx_aclk : IN STD_LOGIC;
        m00_axis_rx_aresetn : IN STD_LOGIC;
        m00_axis_rx_tvalid : OUT STD_LOGIC;
        m00_axis_rx_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m00_axis_rx_tready : IN STD_LOGIC;
        s00_axis_tx_aclk : IN STD_LOGIC;
        s00_axis_tx_aresetn : IN STD_LOGIC;
        s00_axis_tx_tready : OUT STD_LOGIC;
        s00_axis_tx_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s00_axis_tx_tvalid : IN STD_LOGIC);
    END COMPONENT;
    
    -- declaration of the rgb2bw component
    COMPONENT rgb2bw
        PORT (
        red : in STD_LOGIC_VECTOR (7 downto 0);
        green : in STD_LOGIC_VECTOR (7 downto 0);
        blue : in STD_LOGIC_VECTOR (7 downto 0);
        bw : out STD_LOGIC_VECTOR (7 downto 0);
        clk : in STD_LOGIC);
    END COMPONENT;
    
    COMPONENT blk_mem_gen_0
        PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clkb : IN STD_LOGIC;
        enb : IN STD_LOGIC;
        addrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT Address_Generator
	PORT(
		CLK      : IN  std_logic;
		enable      : IN  std_logic; 
      rez_160x120 : IN std_logic;
      rez_320x240 : IN std_logic;      
      vsync       : in  STD_LOGIC;
		address     : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
	COMPONENT clk_wiz_0 
    port (
    clk_in1         : in std_logic;
    reset           : in std_logic;
    --locked          : out std_logic;
    -- Clock out ports
    CLK100MHz          : out    std_logic;
    CLK25MHz          : out    std_logic);
	end COMPONENT;
	
	COMPONENT VGA
	PORT(
		CLK25 : IN std_logic;    
      rez_160x120 : IN std_logic;
      rez_320x240 : IN std_logic;
		Hsync : OUT std_logic;
		Vsync : OUT std_logic;
		Nblank : OUT std_logic;      
		clkout : OUT std_logic;
		activeArea : OUT std_logic;
		Nsync : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT RGB
	PORT(
		Din : IN std_logic_vector(7 downto 0);
--		Din_r : IN std_logic_vector(3 downto 0);
		Nblank : IN std_logic;          
		R : OUT std_logic_vector(7 downto 0);
		G : OUT std_logic_vector(7 downto 0);
		B : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
    
    --  reset signal (active low) 
    signal rstn : STD_LOGIC;
    
    -- dati ricevuti (in uscita dal ricevitore)
    signal rxdata : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- indica che sono stati ricevuti correttamente dei dati (in uscita dal ricevitore)
    signal rxvalid : STD_LOGIC;
    -- indica al ricevitore che il blocco ad esso collegato è pronto a ricevere dei dati (in ingresso al ricevitore)
    signal rxready : STD_LOGIC;
    
    -- dati da inviare (in ingresso al trasmettitore)
    signal txdata : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal txdata_temp : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- indica al trasmettitore che sono presenti dati validi da inviare (in ingresso al trasmettitore)
    signal txvalid : STD_LOGIC;
    -- indica che il trasmettitore è pronto per l'invio di dati (in uscita dal trasmettitore)
    signal txready : STD_LOGIC;
    
    -- buffer dato rosso
    signal redbuffer : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- buffer dato verde
    signal greenbuffer : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- buffer dato blu
    signal bluebuffer : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- indice del buffer utilizzato (0=rosso, 1=verde, 2=blu)
    signal buffer_index : INTEGER RANGE 0 TO 2;
    -- indica che è richiesta la trasmissione
    signal txrequested : boolean;
    
    --read address to display
    signal rdaddress_disp : std_logic_vector(15 downto 0):= (others => '0');
--    write address of bw ram, has to give manually
    signal wr_address_disp : std_logic_vector(15 downto 0);
    signal wr_en : std_logic_vector(0 downto 0); --write enable for ram, has to set manually
    
    signal rddisp           : std_logic_vector(7 downto 0);
        
    signal vSync      : std_logic;
    signal nSync      : std_logic;
    
    signal red_disp,green_disp,blue_disp : std_logic_vector(7 downto 0);
    
    signal clk_vga    : std_logic;
    
    signal activeArea : std_logic;
    
    signal nBlank     : std_logic;       
    signal rez_160x120 : std_logic;
    signal rez_320x240 : std_logic;
    
begin
    rez_160x120 <= '1';
    rez_320x240 <= '0';
    
    vga_r <= red_disp(7 downto 4);
       vga_g <= green_disp(7 downto 4);
       vga_b <= blue_disp(7 downto 4);

    -- istanza del componente AXI4Stream_RS232_0
    com_instance : AXI4Stream_RS232_0
        PORT MAP (
            clk_uart => clk,
            rst => rst,
            RS232_TX => tx,
            RS232_RX => rx,
            m00_axis_rx_aclk => clk,
            m00_axis_rx_aresetn => rstn,
            m00_axis_rx_tvalid => rxvalid,
            m00_axis_rx_tdata => rxdata,
            m00_axis_rx_tready => rxready,
            s00_axis_tx_aclk => clk,
            s00_axis_tx_aresetn => rstn,
            s00_axis_tx_tready => txready,
            s00_axis_tx_tdata => txdata,
            s00_axis_tx_tvalid => txvalid);
            
    -- istanza del componenete rgb2bw
    rgb2bw_instance : rgb2bw
        PORT MAP (
            red => redbuffer,
            green => greenbuffer,
            blue => bluebuffer,
            bw => txdata,
            clk => clk);
            
    Inst_Address_Generator: Address_Generator PORT MAP(
		CLK => clk_vga,
        rez_160x120 => rez_160x120,
        rez_320x240 => rez_320x240,
		enable => activeArea,
        vsync  => vsync,
		address => rdaddress_disp
	);
	
	Inst_ClockDev : clk_wiz_0
     port map
      (-- Clock in ports
       clk_in1 => clk,
       reset => '0',
       --locked => '1',
       -- Clock out ports
       CLK25MHZ => CLK_vga); 
       
    vga_vsync <= vsync;
   
	Inst_VGA: VGA PORT MAP(
		CLK25      => clk_vga,
      rez_160x120 => rez_160x120,
      rez_320x240 => rez_320x240,
		clkout     => open,
		Hsync      => vga_hsync,
		Vsync      => vsync,
		Nblank     => nBlank,
		Nsync      => nsync,
      activeArea => activeArea
	);
	
	Inst_RGB: RGB PORT MAP(
		Din => rddisp,
		Nblank => activeArea,
		R => red_disp,
		G => green_disp,
		B => blue_disp
	);
	
	Inst_bw_buffer: blk_mem_gen_0 PORT MAP(
	    enb => '1',
		addrb => rdaddress_disp,
		clkb   => clk_vga,
		doutb  => rddisp,
		clka   => clk,--CLK_camera, --CLK100,
		ena => '1',
		addra => wr_address_disp,
		dina      => txdata,
		wea      => wr_en
	);

    -- reset signal (active low) for serial rtx
    rstn <= not rst;
    
    -- the processing system is realtime: I am always ready to receive serial data
    rxready <= '1';
    wr_en<="1";
    
    -- processing process
    serial_image_processor  :  process(clk)
    
    begin
        if rising_edge(clk) then 
        if (wr_en = "1") and (not(txdata=txdata_temp)) then
            wr_address_disp <= wr_address_disp+1;
            txdata_temp<=txdata;
         end if;
        end if;
    
        if rst = '1' then
            -- reset required
            buffer_index        <= 0;
 
        elsif rising_edge(clk) then
        
            -- check if I have valid data
            if (rxvalid = '1') then
                -- I received a new data: I have to save it in the appropriate buffer
                if (buffer_index = 0) then
                    redbuffer <= rxdata;
                    buffer_index <= 1;
--                    enable frame buffer for red here
                elsif (buffer_index = 1) then
                    greenbuffer <= rxdata;
                    buffer_index <= 2;
                elsif (buffer_index = 2) then
                    bluebuffer <= rxdata;
                    buffer_index <= 0;
                    txrequested <= true;
                else
                    -- impossibile
                end if;
            end if;
            
            -- check if I can send
            if (txrequested = true and txready = '1') then
                -- transmission command
                txvalid <= '1';
                -- request fulfilled
                txrequested <= false;
            else
                -- end of transmission
                txvalid <= '0';
            end if; 
               
        end if;

    end process;

end Behavioral;
