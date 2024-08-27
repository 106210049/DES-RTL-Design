
module tb_DES_Cryp;

  // Testbench signals
  logic clk;
  logic rst_n;
  logic des_cipher_en;
  logic [63:0] des_data;
  logic [63:0] des_key_in;
  
  // Outputs
  logic desc_ready;
  logic [63:0] desc_ciphertext;

  // Instantiate the DES_Cryp module
  DES_Cryp des_inst (
    .clk(clk),
    .rst_n(rst_n),
    .des_cipher_en(des_cipher_en),
    .des_data(des_data),
    .des_key_in(des_key_in),
    .desc_ready(desc_ready),
    .desc_ciphertext(desc_ciphertext)
  );

  // Clock generation
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    clk = 0;
    forever #5 clk = ~clk; // Clock period of 10 ns
  end

  // Test cases
  initial begin
    // Initialize inputs
    rst_n = 0;
    des_cipher_en = 0;
    des_data	= 64'h00123456789abcde;
 	des_key_in	= 64'h0133457799bbcdff;
	
    // Reset the design
    #10;
    rst_n = 1;

    // Enable DES encryption
    #50;
    des_cipher_en = 1;
	#20
    des_cipher_en=0;
    // Wait for some clock cycles for the encryption to complete
    wait(desc_ready==1);

    // Display results
    #10;
    $display("===================================");
    $display("Ciphertext: %h", desc_ciphertext);
    $display("Ready: %b", desc_ready);
    $display("===================================");

    // Disable DES encryption
    des_cipher_en = 0;
   
    // Finish the simulation
    #500;
    $finish;
  end

endmodule
