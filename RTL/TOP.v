module top( 
    input          i_clk, 
    input          i_rst, 
    input          i_ena, 
    output         o_pm, 
    output [7 : 0] o_hh, 
    output [7 : 0] o_mm, 
    output [7 : 0] o_ss 
); 

// 内部二进制寄存器用于时间保持
reg [5:0] sec_reg;  // 0-59 秒
reg [5:0] min_reg;  // 0-59 分
reg [3:0] hour_reg; // 0-11 小时
reg       pm_reg;   // 0 表示上午 (AM), 1 表示下午 (PM)

// 时钟逻辑
always @(posedge i_clk) begin
    if (i_rst) begin // 异步复位，优先级最高
        sec_reg  <= 0;
        min_reg  <= 0;
        hour_reg <= 0;
        pm_reg   <= 0; // 复位到上午 (AM)
    end else if (i_ena) begin
        if (sec_reg == 59) begin
            sec_reg <= 0;
            if (min_reg == 59) begin
                min_reg <= 0;
                if (hour_reg == 11) begin
                    hour_reg <= 0;
                    pm_reg <= ~pm_reg; // 翻转上午/下午
                end else begin
                    hour_reg <= hour_reg + 1;
                end
            end else begin
                min_reg <= min_reg + 1;
            end
        end else begin
            sec_reg <= sec_reg + 1;
        end
    end
end

// 输出赋值与BCD码转换
assign o_pm = pm_reg;

// 秒数转换为BCD码
assign o_ss[7:4] = sec_reg / 10;
assign o_ss[3:0] = sec_reg % 10;

// 分钟数转换为BCD码
assign o_mm[7:4] = min_reg / 10;
assign o_mm[3:0] = min_reg % 10;

// 小时数转换为BCD码
assign o_hh[7:4] = hour_reg / 10;
assign o_hh[3:0] = hour_reg % 10;

endmodule
