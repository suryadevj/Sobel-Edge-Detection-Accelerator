module sobel (
    input clk,
    input rst,

    input [7:0] p1,
    input [7:0] p2,
    input [7:0] p3,
    input [7:0] p4,
    input [7:0] p5,
    input [7:0] p6,
    input [7:0] p7,
    input [7:0] p8,
    input [7:0] p9,

    output reg [11:0] edge_out
);

    // Stage-1 Registers
    reg signed [10:0] gx_s1;
    reg signed [10:0] gy_s1;

    // Stage-2 Registers
    reg [10:0] abs_gx_s2;
    reg [10:0] abs_gy_s2;

    // Stage-1 : Compute Gx and Gy
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            gx_s1 <= 0;
            gy_s1 <= 0;
        end
        else
        begin
            gx_s1 <=
                    ($signed({1'b0,p3}) +
                    ($signed({1'b0,p6}) <<< 1) +
                     $signed({1'b0,p9}))
                    -
                    ($signed({1'b0,p1}) +
                    ($signed({1'b0,p4}) <<< 1) +
                     $signed({1'b0,p7}));

            gy_s1 <=
                    ($signed({1'b0,p7}) +
                    ($signed({1'b0,p8}) <<< 1) +
                     $signed({1'b0,p9}))
                    -
                    ($signed({1'b0,p1}) +
                    ($signed({1'b0,p2}) <<< 1) +
                     $signed({1'b0,p3}));
        end
    end

    // Stage-2 : Absolute Values
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            abs_gx_s2 <= 0;
            abs_gy_s2 <= 0;
        end
        else
        begin
            abs_gx_s2 <= (gx_s1 < 0) ? -gx_s1 : gx_s1;
            abs_gy_s2 <= (gy_s1 < 0) ? -gy_s1 : gy_s1;
        end
    end

    // Stage-3 : Edge Magnitude
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            edge_out <= 0;
        else
            edge_out <= abs_gx_s2 + abs_gy_s2;
    end

endmodule