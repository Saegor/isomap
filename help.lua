cmd_msg = {

	" right \n left" ..
	"\n\n down \n up" ..
	"\n\n s \n d" ..
	"\n\n e \n r" ..
	"\n\n t \n y" ..
	"\n\n f" ..
	"\n\n\n g" ..
	"\n\n\n h" ..
	"\n\n\n j" ..
	"\n\n\n k",

	" move X" ..
	"\n\n\n move Y" ..
	"\n\n\n move Z" ..
	"\n\n\n change angle of view" ..
	"\n\n\n zoom in and out" ..
	"\n\n\n set angle and zoom to default" ..
	"\n\n\n switch field of view" ..
	"\n\n\n switch grid lines" ..
	"\n\n\n map rotation (counterclockwise)" ..
	"\n\n\n map rotation (clockwise)"
}

function print_help()
	
	if ke.isDown("tab") then

		gr.setColor(0xFF, 0xFF, 0xC0)
		gr.printf(cmd_msg[1], 60, 20, 0, "right")
		gr.setColor(0xFF, 0xC0, 0xFF)
		gr.print(cmd_msg[2], 80, 20)
		
	else
		gr.setColor(0xA0, 0xA0, 0xA0)
		gr.print(ti.getFPS() ..
		" fps\npress tab", 20, 20)
	end
end
