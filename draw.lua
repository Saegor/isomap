function block_draw(gx, gy, gz, v)
	
	-- check if player must be drawn instead of block
	v = player:check(gx, gy, gz) and "player" or v

	-- abort if there is no block to draw
	if v == "empty" then return end

	-- get corners coordinates
	local
	x1, y1, x2, y2, x3, y3, x4, y4,
	x5, y5, x6, y6, x7, y7, x8, y8 =
	block_getVertices(gx, gy, gz)
	
	-- check if the block is visible
	if onScreen(x1, y2, x3, y8) then
				
		-- localize distance
		local dist = switch_light and 0
		
		-- vs in front of v
		local v_fx = block_getValue(gx + 1, gy, gz)
		local v_fy = block_getValue(gx, gy + 1, gz)
		local v_fz = block_getValue(gx, gy, gz + 1)

		-- water level
		if v == "water" and v_fz == "empty" then
		
			local lz = tile_z/2
			
			y5, y7 = y5 + lz, y7 + lz
			y6, y8 = y6 + lz, y8 + lz
		
			-- waves (merci darky, ca pulse sec)
			local ampl, phase = lz/4, math.sin(
			
				4 * love.timer.getTime() % (2 * math.pi) +
				(gx % 2 + gy % 2) % 2 * math.pi
			)

			local wave = ampl * phase

			y5, y7 = y5 + wave, y7 + wave
			y6, y8 = y6 - wave, y8 - wave
		end
		
		--if transparent, draw back faces
		if block_getAlpha(v) then
		
			-- vs behind v (not hided if v is transparent)
			local v_bx = block_getValue(gx - 1, gy, gz)
			local v_by = block_getValue(gx, gy - 1, gz)
			local v_bz = block_getValue(gx, gy, gz - 1)
			
			--back right
			if v_bx ~= v then
			
				local angle = -1
				dist = dist or getDist(gx, gy, gz)
				
				face_setColor(v, angle, dist)
				face_draw(x3, y3, x4, y4, x8, y8, x7, y7)
			end

			--back left
			if v_by ~= v then

				local angle = 1
				dist = dist or getDist(gx, gy, gz)
				
				face_setColor(v, angle, dist)
				face_draw(x4, y4, x1, y1, x5, y5, x8, y8)
			end
			
			--back bottom
			if v_bz ~= v then
			
				dist = dist or getDist(gx, gy, gz)
				
				face_setColor(v, angle, dist)			
				face_draw(x1, y1, x2, y2, x3, y3, x4, y4)
			end
		end

		--front right
		if v_fx ~= v and block_getAlpha(v_fx) then

			local angle = 1
			dist = dist or getDist(gx, gy, gz)

			face_setColor(v, angle, dist)
			face_draw(x1, y1, x2, y2, x6, y6, x5, y5)
		end

		--front left		
		if v_fy ~= v and block_getAlpha(v_fy) then
		
			local angle = -1
			dist = dist or getDist(gx, gy, gz)

			face_setColor(v, angle, dist)
			face_draw(x2, y2, x3, y3, x7, y7, x6, y6)
		end

		--front up, surface		
		if v_fz ~= v and block_getAlpha(v_fz) then
		
			local v =
			v == "ground" and v_fz == "empty"
			and "grass" or v
			
			dist = dist or getDist(gx, gy, gz)
			
			face_setColor(v, angle, dist)
			face_draw(x5, y5, x6, y6, x7, y7, x8, y8)
		end
	end
end

function face_draw(xa, ya, xb, yb, xc, yc, xd, yd)

	gr.quad("fill", xa, ya, xb, yb, xc, yc, xd, yd)

	if switch_line then

		gr.setColor(0xFF, 0xFF, 0xFF, 0x20)
		gr.setLineWidth(zoom)
		gr.quad("line", xa, ya, xb, yb, xc, yc, xd, yd)
	end
end
