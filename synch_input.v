//Synchronizer
`timescale 1ns / 1ps

module synch_input(
                    input clk,
                    input sync_button,
                    output reg one_pulse
                    );

    reg [2:0] current_state;
    reg [2:0] state_next;


initial
    begin
        current_state  <= 0;
        state_next <= 0;
    end


always @(*) 
begin
    begin
    case(current_state)
    0:begin
        if(sync_button == 1'b1) 
        begin
            one_pulse = 1;
            state_next = 1;
        end
        else 
        begin
            one_pulse = 0;
            state_next = 0;
        end
    end

    1:begin
        if(sync_button == 1'b0) 
            begin
                one_pulse = 0;
                state_next = 0;
            end
        else 
            begin
                one_pulse = 0;
                state_next = 1;
            end
        end

    default : begin
    end
    endcase
    end
end 

always @ (posedge clk) 
    begin
        current_state <= state_next;
    end
endmodule