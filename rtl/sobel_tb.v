module sobel_tb;

reg clk;
reg rst;

reg [7:0] p1,p2,p3,p4,p5,p6,p7,p8,p9;
wire [11:0] edge_out;

sobel DUT(
    .clk(clk),
    .rst(rst),
    .p1(p1),
    .p2(p2),
    .p3(p3),
    .p4(p4),
    .p5(p5),
    .p6(p6),
    .p7(p7),
    .p8(p8),
    .p9(p9),
    .edge_out(edge_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    p1=0; p2=0; p3=0;
    p4=0; p5=0; p6=0;
    p7=0; p8=0; p9=0;

    #20 rst = 0;

    p1=10; p2=10; p3=200;
    p4=10; p5=10; p6=200;
    p7=10; p8=10; p9=200;

    #20;

    p1=20; p2=20; p3=20;
    p4=20; p5=20; p6=20;
    p7=200; p8=200; p9=200;

    #100 $finish;
end

endmodule