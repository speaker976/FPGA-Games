/*=======================================================
Author				:				QiiNn
Email Address		:				ctlvie@gmail.com
Filename			:				game_mode.v
Date				:				2018-05-11
Description			:				

Modification History:
Date		By			Version		Description
----------------------------------------------------------
========================================================*/

module  game_mode
(
	input 				clk,
	input	[4:0]		sw,	
	input 				bt_st,
	input 	[2:0]		HP_value,
	input				gameover,
	output		reg		enable_bul1,
	output		reg		enable_bul2,
	output		reg		enable_bul3,
	output		reg		enable_bul4,
	output		reg		enable_mybul,
	output		reg		enable_mytank_app,
	output		reg		enable_mytank_phy,
	output		reg		enable_enytank1_app,
	output		reg		enable_enytank1_phy,
	output		reg		enable_enytank2_app,
	output		reg		enable_enytank2_phy,
	output		reg		enable_enytank3_app,
	output		reg		enable_enytank3_phy,
	output		reg		enable_enytank4_app,
	output		reg		enable_enytank4_phy,
	output		reg		enable_gamelogic,
	output 		reg		[2:0] mode
);              
                
initial mode <= 0;

always@(posedge clk )
begin
case (mode)
0:
begin
	enable_bul1			<= 1'b0;
	enable_bul2 		<= 1'b0;
	enable_bul3 		<= 1'b0;
	enable_bul4 		<= 1'b0;
	enable_mybul		<= 1'b0;
	enable_mytank_app	<= 1'b0;
	enable_mytank_phy	<= 1'b0;
	enable_enytank1_app <= 1'b0;
	enable_enytank1_phy <= 1'b0;
	enable_enytank2_app <= 1'b0;
	enable_enytank2_phy <= 1'b0;
	enable_enytank3_app <= 1'b0;
	enable_enytank3_phy <= 1'b0;
	enable_enytank4_app <= 1'b0;
	enable_enytank4_phy <= 1'b0;
	enable_gamelogic	<= 1'b0;
	if(bt_st == 1)
		mode <= 1;
	else
		mode <= 0;
end
1:
begin
	enable_bul1			<= 1'b1;
	enable_bul2 		<= 1'b1;
	enable_bul3 		<= 1'b1;
	enable_bul4 		<= 1'b1;
	enable_mybul		<= 1'b1;
	enable_mytank_app	<= 1'b1;
	enable_mytank_phy	<= 1'b1;
	enable_enytank1_app <= 1'b1;
	enable_enytank1_phy <= 1'b1;
	enable_enytank2_app <= 1'b1;
	enable_enytank2_phy <= 1'b1;
	enable_enytank3_app <= 1'b1;
	enable_enytank3_phy <= 1'b1;
	enable_enytank4_app <= 1'b1;
	enable_enytank4_phy <= 1'b1;
	enable_gamelogic	<= 1'b1;
	if( gameover == 1)
		mode <= 2;
	else
		mode <= 1;
end
2:
begin
	enable_bul1			<= 1'b0;
	enable_bul2 		<= 1'b0;
	enable_bul3 		<= 1'b0;
	enable_bul4 		<= 1'b0;
	enable_mybul		<= 1'b0;
	enable_mytank_app	<= 1'b0;
	enable_mytank_phy	<= 1'b0;
	enable_enytank1_app <= 1'b0;
	enable_enytank1_phy <= 1'b0;
	enable_enytank2_app <= 1'b0;
	enable_enytank2_phy <= 1'b0;
	enable_enytank3_app <= 1'b0;
	enable_enytank3_phy <= 1'b0;
	enable_enytank4_app <= 1'b0;
	enable_enytank4_phy <= 1'b0;
	enable_gamelogic	<= 1'b0;
	if(sw[0] == 1)
		mode <= 0;
	else
		mode <= 2;
end
endcase
end

endmodule