`timescale 1ns / 1ps

module stopwatch_tb;

  
    // Testbench signals
  
    reg clock;
    reg reset;
    reg start;

    wire a, b, c, d, e, f, g, dp;
    wire [3:0] an;

  
    // Instantiate the DUT
    
    stopwatch uut (
        .clock(clock),
        .reset(reset),
        .start(start),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .dp(dp),
        .an(an)
    );

    
    // Clock generation
    // 50 MHz clock → 20 ns period
    
    always begin
        #10 clock = ~clock;
    end

    
    // Test sequence
    
    initial begin
        // Initialize signals
        clock = 0;
        reset = 1;
        start = 0;

        // Hold reset
        #100;
        reset = 0;

        // Wait, then start stopwatch
        #100;
        start = 1;

        // Let code run for some time
        #200_000_000;  // adjust if needed

        // Stop stopwatch
        start = 0;

        // Pause
        #100_000_000;

        // Restart stopwatch
        start = 1;

        // Run again
        #200_000_000;

        // End simulation
        $stop;
    end

endmodule
