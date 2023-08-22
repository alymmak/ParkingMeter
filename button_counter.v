`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module button_counter(CLK, CLK_1sec, CLK_2sec, button_U, button_L, button_R, button_D, RESET_10, RESET_205, sec_out0, sec_out1, sec_out2, sec_out3, LED);
input CLK, CLK_1sec, CLK_2sec, button_U, button_L, button_R, button_D, RESET_10, RESET_205;
output reg LED;
output reg[3:0] sec_out0;
output reg[3:0] sec_out1;
output reg[3:0] sec_out2;
output reg[3:0] sec_out3;


reg[15:0] count;
reg[15:0] display_value;
reg[1:0] on_off;

reg[1:0] module_type;
reg[1:0] next_module;

initial 
begin
    count <= 0;
    display_value <= 0;
    on_off <= 0;
    LED <= 0;
end


always @(posedge CLK)
begin
    // first if 
    if(RESET_10)
    begin 
        count <= 10;
        LED <= 1;
    end
    else if(RESET_205)
    begin
        count <= 205;
        LED <= 1;
    end
    else if(count >= 9999)
    begin
        count <= 9999;
    end
    else if(button_U)
    begin
        if((count + 10) >= 9999)
        begin
            count <= 9999;
        end
        else
        begin 
            count <= count + 10;
        end
    end
    else if(button_L == 1)
    begin 
        if((count + 180) >= 9999)
        begin
            count <= 9999;
        end
        else
        begin 
            count <= count + 180;
        end
    end
    else if(button_R == 1)
    begin 
        if((count + 200) >= 9999)
        begin
            count <= 9999;
        end
        else
        begin 
            count <= count + 200;
        end
    end
    else if(button_D == 1)
    begin 
        if((count + 550) >= 9999)
        begin
            count <= 9999;
        end
        else
        begin 
            count <= count + 550;
        end
    end
    else
    begin
        count <= count; 
    end
    // second if
    if(CLK_1sec)
    begin
        if((count > 0) && (RESET_10 == 0) && (RESET_205 == 0))
        begin
            count <= count - 1;
        end
        else
        begin
            count <= count;
        end
     end
end



always @(*) 
    begin
        case(module_type)   
            2'b00: next_module = 2'b01;
            2'b01: next_module = 2'b10;
            2'b10: next_module = 2'b11;
            2'b11: next_module = 2'b00;
        endcase
    end    

always @(*)
    begin    
        case (module_type)
            2'b00: 
                begin
                    if((count == 0))
                    begin
                        sec_out0 <= 0;
                        sec_out1 <= 0;
                        sec_out2 <= 0;
                        sec_out3 <= 0;    
                    end
                    else if(count < 200)
                    begin
                        sec_out0 = (count % 10);
                        sec_out1 = ((count / 10) % 10);
                        sec_out2 = ((count / 100) % 10);
                        sec_out3 = ((count / 1000) % 10);
                    end  
                    else
                    begin
                        sec_out0 = (count % 10);
                        sec_out1 = ((count / 10) % 10);
                        sec_out2 = ((count / 100) % 10);
                        sec_out3 = ((count / 1000) % 10);
                    end    
                end
            2'b01:
                begin
                    if((count == 0))
                    begin
                        sec_out0 <= 4'b1111;
                        sec_out1 <= 4'b1111;
                        sec_out2 <= 4'b1111;
                        sec_out3 <= 4'b1111;    
                    end
                    else if(count < 200)
                    begin
                        sec_out0 = (count % 10);
                        sec_out1 = ((count / 10) % 10);
                        sec_out2 = ((count / 100) % 10);
                        sec_out3 = ((count / 1000) % 10);
                    end  
                    else
                    begin
                        sec_out0 = (count % 10);
                        sec_out1 = ((count / 10) % 10);
                        sec_out2 = ((count / 100) % 10);
                        sec_out3 = ((count / 1000) % 10);
                    end                       
                end
             
            2'b10:
                begin 
                    if(count == 0)
                    begin
                        sec_out0 <= 0;
                        sec_out1 <= 0;
                        sec_out2 <= 0;
                        sec_out3 <= 0;    
                    end
                    else if(count < 200)
                    begin
                        sec_out0 <= 4'b1111;
                        sec_out1 <= 4'b1111;
                        sec_out2 <= 4'b1111;
                        sec_out3 <= 4'b1111; 
                    end  
                    else
                    begin
                        sec_out0 = (count % 10);
                        sec_out1 = ((count / 10) % 10);
                        sec_out2 = ((count / 100) % 10);
                        sec_out3 = ((count / 1000) % 10);
                    end
                end
        2'b11:
            begin
                    if(count == 0)
                    begin
                        sec_out0 <= 4'b1111;
                        sec_out1 <= 4'b1111;
                        sec_out2 <= 4'b1111;
                        sec_out3 <= 4'b1111;    
                    end
                    else if(count < 200)
                    begin
                        sec_out0 <= 4'b1111;
                        sec_out1 <= 4'b1111;
                        sec_out2 <= 4'b1111;
                        sec_out3 <= 4'b1111; 
                    end  
                    else
                    begin
                        sec_out0 = (count % 10);
                        sec_out1 = ((count / 10) % 10);
                        sec_out2 = ((count / 100) % 10);
                        sec_out3 = ((count / 1000) % 10);
                    end
            end 
        default: 
            begin
                sec_out0 <= 0;
                sec_out1 <= 0;
                sec_out2 <= 0;
                sec_out3 <= 0;
            end
    endcase
end
    
always @(posedge CLK_2sec) 
    begin
        module_type <= next_module;
    end

endmodule
