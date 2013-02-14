-- set mouse and keyboard options
function input_init()

	mo.setVisible(false)
	ke.setKeyRepeat(.1, .1)
end

function input_stream(dt)

	-- stabilize dt
	local dt = dt < .1 and dt or .1

	if ke.isDown("r")
	and factor_h/factor_w < 2 then

		camera_rotate(1, dt)

	elseif ke.isDown("e")
	and factor_h/factor_w > 1/2 then

		camera_rotate(-1, dt)
	end
	
	if ke.isDown("t")
	and zoom < 2 then
	
		camera_zoom(1, dt)

	elseif ke.isDown("y")
	and zoom > 1/2 then
	
		camera_zoom(-1, dt)
	end
end

function input_keypressed(k)

	if k == "d" then

		player:move(0, 0, 1)
		
	elseif k == "s" then

		player:move(0, 0, -1)
	end
	
	if k == "right" then

		player:move(1, 0, 0)
		
	elseif k == "left" then

		player:move(-1, 0, 0)
	end
	
	if k == "down" then

		player:move(0, 1, 0)
		
	elseif k == "up" then

		player:move(0, -1, 0)
	end
	
	if k == "escape"
	or k == "return" then
	
		love.event.quit()
	end

	-- set camera var to default
	if k == "f" then

		factor_w,
		factor_h,
		factor_z,
		zoom = nil
		
		tile_update()
	end
	
	if k == "g" then
	
		switch_light = not switch_light
	end
	
	if k == "h" then
	
		switch_line = not switch_line
	end
	
	if k == "j" then
	
		map_rotate()
	end

	if k == "k" then
	
		map_rotate(true)
	end	
end
