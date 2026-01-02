module stopwatch(
    input clock,       // System clock
    input reset,       // Asynchronous reset
    input start,       // Start/Stop control
    output a, b, c, d, e, f, g, dp, // 7-segment outputs
    output [3:0] an    // 7-segment anode control
);


// Registers to hold individual digits

reg [3:0] reg_d0, reg_d1, reg_d2, reg_d3; // D0: 0.1s, D1: 1s, D2: 10s, D3: minutes
reg [22:0] ticker;                         // Counts clock cycles for 0.1 second tick
wire click;                                // Tick signal every 0.1 second


// Clock divider: generate 0.1s tick

always @(posedge clock or posedge reset) begin
    if (reset)
        ticker <= 0;
    else if (ticker == 5000000)           // Adjust based on your FPGA clock frequency
        ticker <= 0;
    else if (start)                       // Increment only if stopwatch is started
        ticker <= ticker + 1;
end

// Tick goes high every 0.1 second
assign click = (ticker == 5000000) ? 1'b1 : 1'b0;

  
// Main counting logic

always @(posedge clock or posedge reset) begin
    if (reset) begin
        reg_d0 <= 0;
        reg_d1 <= 0;
        reg_d2 <= 0;
        reg_d3 <= 0;
    end
    else if (click) begin
        // Increment 0.1s digit
        if (reg_d0 == 9) begin
            reg_d0 <= 0;

            // Increment 1s digit
            if (reg_d1 == 9) begin
                reg_d1 <= 0;

                // Increment 10s of seconds
                if (reg_d2 == 5) begin
                    reg_d2 <= 0;

                    // Increment minutes
                    if (reg_d3 == 9)
                        reg_d3 <= 0;
                    else
                        reg_d3 <= reg_d3 + 1;
                end
                else
                    reg_d2 <= reg_d2 + 1;
            end
            else
                reg_d1 <= reg_d1 + 1;
        end
        else
            reg_d0 <= reg_d0 + 1;
    end
end


// 7-segment display multiplexing

localparam N = 18;               // Counter bits for multiplexing
reg [N-1:0] count;               // Multiplexing counter

always @(posedge clock or posedge reset) begin
    if (reset)
        count <= 0;
    else
        count <= count + 1;
end

reg [6:0] sseg;                  // Current digit to display
reg [3:0] an_temp;               // Temporary anode value
reg reg_dp;                       // Decimal point control

always @(*) begin
    case (count[N-1:N-2])
        2'b00: begin
            sseg = reg_d0;       // 0.1s digit
            an_temp = 4'b1110;
            reg_dp = 1'b1;
        end
        2'b01: begin
            sseg = reg_d1;       // 1s digit
            an_temp = 4'b1101;
            reg_dp = 1'b0;
        end
        2'b10: begin
            sseg = reg_d2;       // 10s digit
            an_temp = 4'b1011;
            reg_dp = 1'b1;
        end
        2'b11: begin
            sseg = reg_d3;       // Minutes digit
            an_temp = 4'b0111;
            reg_dp = 1'b0;
        end
    endcase
end

assign an = an_temp;              // Connect anodes to display


// 7-segment decoder

reg [6:0] sseg_temp;

always @(*) begin
    case (sseg)
        4'd0 : sseg_temp = 7'b1000000;
        4'd1 : sseg_temp = 7'b1111001;
        4'd2 : sseg_temp = 7'b0100100;
        4'd3 : sseg_temp = 7'b0110000;
        4'd4 : sseg_temp = 7'b0011001;
        4'd5 : sseg_temp = 7'b0010010;
        4'd6 : sseg_temp = 7'b0000010;
        4'd7 : sseg_temp = 7'b1111000;
        4'd8 : sseg_temp = 7'b0000000;
        4'd9 : sseg_temp = 7'b0010000;
        default : sseg_temp = 7'b0111111; // dash
    endcase
end

// Assign to outputs
assign {g, f, e, d, c, b, a} = sseg_temp;
assign dp = reg_dp;

endmodule
