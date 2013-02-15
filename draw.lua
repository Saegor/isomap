function block_draw(gx, gy, gz, v)
	
	-- check if player must be drawn instead of block
	v = player:check(gx, gy, gz) and "player" or v

	-- abort if there is no block to draw
	if not v or v == "empty" then return end

	-- get corners coordinates
	local
	x1, y1, x2, y2, x3, y3, x4, y4,
	x5, y5, x6, y6, x7, y7, x8, y8 =
	block_getVertices(gx, gy, gz)
	
	-- check if the block is visible
	if onScreen(x1, y2, x3, y8) then
				
		-- localize distance (0 or nil) and angle (nil)
		local dist, angle = switch_light and 0
		
		-- values in front of v
		local v_fz = block_getValue(gx, gy, gz + 1)

--NEW ROTATION
		local v_fx, v_fy =
		block_getValue(gx, gy + map_Y, gz),
		block_getValue(gx + map_X, gy , gz)

		if map_Y == map_X then v_fx, v_fy = v_fy, v_fx end
-- NEW ROTATION
		
		-- water FX
		if v == "water"	and v_fz == "empty" then

			-- water level
			local lz = tile_z/4

			-- waves (merci darky, ca pulse sec)
			local wz = lz/4 * math.sin(

				4 * love.timer.getTime() % (2 * math.pi) +
				(gx % 2 + gy % 2) % 2 * math.pi
			)

			-- apply
			y5 = y5 + lz + wz
			y6 = y6 + lz - wz
			y7 = y7 + lz + wz
			y8 = y8 + lz - wz
		end

		--if transparent, draw back faces
		if block_getAlpha(v) then

			-- values behind v (not hided if v is transparent)
			local v_bz = block_getValue(gx, gy, gz - 1)

--NEW ROTATION
			local v_bx, v_by =
			block_getValue(gx, gy - map_Y, gz),
			block_getValue(gx - map_X, gy, gz)
			
			if map_Y == map_X then v_bx, v_by = v_by, v_bx end
--NEW ROTATION
			
			--back bottom
			if v_bz ~= v then
			
				angle = 0
				dist = dist or getDist(gx, gy, gz)
				
				face_setColor(v, dist, angle)			
				face_draw(x1, y1, x2, y2, x3, y3, x4, y4)
			end
			
			--back right
			if v_bx ~= v then

--NEW ROTATION
				angle = - map_Y - map_X/2
--NEW ROTATION
				dist = dist or getDist(gx, gy, gz)
				
				face_setColor(v, dist, angle)
				face_draw(x3, y3, x4, y4, x8, y8, x7, y7)
			end

			--back left
			if v_by ~= v then

--NEW ROTATION
				angle = - map_X + map_Y/2
--NEW ROTATION
				dist = dist or getDist(gx, gy, gz)
				
				face_setColor(v, dist, angle)
				face_draw(x4, y4, x1, y1, x5, y5, x8, y8)
			end
		end

		--front right
		if v_fx ~= v and block_getAlpha(v_fx) then

--NEW ROTATION
			angle = map_Y + map_X/2
--NEW ROTATION
			dist = dist or getDist(gx, gy, gz)

			face_setColor(v, dist, angle)
			face_draw(x1, y1, x2, y2, x6, y6, x5, y5)
		end

		--front left		
		if v_fy ~= v and block_getAlpha(v_fy) then
		
--NEW ROTATION
			angle = map_X - map_Y/2
--NEW ROTATION
			dist = dist or getDist(gx, gy, gz)

			face_setColor(v, dist, angle)
			face_draw(x2, y2, x3, y3, x7, y7, x6, y6)
		end

		--front up, surface		
		if v_fz ~= v and block_getAlpha(v_fz) then
		
			-- sow grass
			local v =
			v == "ground" and v_fz == "empty" 
			and "grass" or v
			
			angle = 0
			dist = dist or getDist(gx, gy, gz)
			
			face_setColor(v, dist, angle)
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
