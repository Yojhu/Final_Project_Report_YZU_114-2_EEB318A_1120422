module top (
    input  wire        clk,        
    input  wire        reset_n,    
    input  wire [7:0]  sw_inputs,  
    input  wire [4:0]  btn_inputs, 
    output reg  [7:0]  led_outputs,
    output wire [3:0]  anode,      
    output wire [6:0]  cathode     
);

    wire [4:0] debounced_btn;

    wire        mem_valid;
    wire        mem_instr;
    reg         mem_ready;
    wire [31:0] mem_addr;
    wire [31:0] mem_wdata;
    wire [3:0]  mem_wstrb;
    reg  [31:0] mem_rdata;

    wire sel_ram       = (mem_addr >= 32'h0000_0000 && mem_addr < 32'h0000_2000);
    wire sel_mmio_in   = (mem_addr == 32'h4000_0000);
    wire sel_mmio_out  = (mem_addr == 32'h5000_0000);

    reg [31:0] ram [0:2047];
    wire [31:0] ram_rdata = ram[mem_addr[12:2]];

    integer idx;
    initial begin
        for (idx = 0; idx < 2048; idx = idx + 1) begin
            ram[idx] = 32'd0;
        end
        $readmemh("firm.mem", ram);
    end

    reg [15:0] seg_data_reg;

    picorv32 #(
        .ENABLE_COUNTERS(1'b0),
        .ENABLE_MUL(1'b0),
        .ENABLE_DIV(1'b0)
    ) cpu_core (
        .clk      (clk),
        .resetn   (reset_n), 
        .mem_valid(mem_valid),
        .mem_instr(mem_instr),
        .mem_ready(mem_ready),
        .mem_addr (mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(mem_rdata),
        .pcpi_wr(1'b0),
        .pcpi_rd(32'd0),
        .pcpi_wait(1'b0),
        .pcpi_ready(1'b0),
        .irq(32'd0)
    );

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            mem_ready <= 1'b0;
        end else begin
            mem_ready <= mem_valid && !mem_ready;
        end
    end

    always @(*) begin
        mem_rdata = 32'd0;
        if (mem_valid) begin
            if (sel_ram) begin
                mem_rdata = ram_rdata;
            end else if (sel_mmio_in) begin
                mem_rdata = {16'b0, debounced_btn, 3'b0, sw_inputs};
            end else if (sel_mmio_out) begin
                mem_rdata = {seg_data_reg, 8'b0, led_outputs};
            end
        end
    end

    always @(posedge clk) begin
        if (mem_valid && sel_ram && |mem_wstrb && mem_ready) begin
            if (mem_wstrb[0]) ram[mem_addr[12:2]][7:0]   <= mem_wdata[7:0];
            if (mem_wstrb[1]) ram[mem_addr[12:2]][15:8]  <= mem_wdata[15:8];
            if (mem_wstrb[2]) ram[mem_addr[12:2]][23:16] <= mem_wdata[23:16];
            if (mem_wstrb[3]) ram[mem_addr[12:2]][31:24] <= mem_wdata[31:24];
        end
    end

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            led_outputs  <= 8'b0;
            seg_data_reg <= 16'h0000;
        end else if (mem_valid && sel_mmio_out && |mem_wstrb && mem_ready) begin
            if (mem_wstrb[0]) led_outputs   <= mem_wdata[7:0];
            if (mem_wstrb[2]) seg_data_reg[7:0]   <= mem_wdata[23:16];
            if (mem_wstrb[3]) seg_data_reg[15:8]  <= mem_wdata[31:24];
        end
    end

    `ifdef SIMULATION
        assign debounced_btn = btn_inputs;
    `else
        debounce btn_db_c (.clk(clk), .reset_n(reset_n), .btn_in(btn_inputs[4]), .btn_out(debounced_btn[4])); 
        debounce btn_db_u (.clk(clk), .reset_n(reset_n), .btn_in(btn_inputs[3]), .btn_out(debounced_btn[3])); 
        debounce btn_db_l (.clk(clk), .reset_n(reset_n), .btn_in(btn_inputs[2]), .btn_out(debounced_btn[2])); 
        debounce btn_db_r (.clk(clk), .reset_n(reset_n), .btn_in(btn_inputs[1]), .btn_out(debounced_btn[1])); 
        debounce btn_db_d (.clk(clk), .reset_n(reset_n), .btn_in(btn_inputs[0]), .btn_out(debounced_btn[0])); 
    `endif

    seven_seg_driver display_unit (
        .clk(clk),
        .display_value(seg_data_reg),
        .anode(anode),
        .cathode(cathode)
    );

endmodule

module debounce (
    input  wire clk,
    input  wire reset_n,
    input  wire btn_in,
    output reg  btn_out
);
    reg [19:0] counter;
    reg        btn_sync_0, btn_sync_1;
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            btn_sync_0 <= 1'b0;
            btn_sync_1 <= 1'b0;
        end else begin
            btn_sync_0 <= btn_in;
            btn_sync_1 <= btn_sync_0;
        end
    end
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter <= 0;
            btn_out <= 1'b0; 
        end else if (btn_sync_1 == btn_out) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 20'hFFFFF) begin 
                btn_out <= btn_sync_1;
                counter <= 0;
            end
        end
    end
endmodule

module seven_seg_driver (
    input  wire        clk,
    input  wire [15:0] display_value, 
    output reg  [3:0]  anode,
    output reg  [6:0]  cathode
);
    reg [16:0] refresh_counter;
    wire [1:0] active_digit = refresh_counter[16:15];
    reg [3:0]  current_nibble;
    always @(posedge clk) refresh_counter <= refresh_counter + 1;
    always @(*) begin
        case(active_digit)
            2'b00: begin anode = 4'b1110; current_nibble = display_value[3:0];   end
            2'b01: begin anode = 4'b1101; current_nibble = display_value[7:4];   end
            2'b10: begin anode = 4'b1011; current_nibble = display_value[11:8];  end
            2'b11: begin anode = 4'b0111; current_nibble = display_value[15:12]; end
        endcase
    end
    always @(*) begin
        case(current_nibble)
            4'h0: cathode = 7'b0000001;
            4'h1: cathode = 7'b1001111;
            4'h2: cathode = 7'b0010010;
            4'h3: cathode = 7'b0000110;
            4'h4: cathode = 7'b1001100;
            4'h5: cathode = 7'b0100100;
            4'h6: cathode = 7'b0100000;
            4'h7: cathode = 7'b0001111;
            4'h8: cathode = 7'b0000000;
            4'h9: cathode = 7'b0000100;
            4'hC: cathode = 7'b1111110;
            default: cathode = 7'b1111111;
        endcase
    end
endmodule