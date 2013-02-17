function engine_init()

	-- set background
	gr.setBackgroundColor(hsl(unpack(colors.sky_night)))

	-- set tile size
	base_w = 0x20 --* math.sqrt(3)/2
	base_h = 0x10
	base_z = 0x20

	tile_update()
	
	-- load map
	map = map_load(require "maps.map_1")

	-- get screen size
	getW = gr.getWidth()
	getH = gr.getHeight()

	-- set input keys
	input_init()
end

function engine_run()

	for gz in ipairs(map) do

--NEW ROTATION
		local min_gy = 1
		local max_gy = #map[gz]
		
		if map_Y == -1 then
		
			min_gy, max_gy = max_gy, min_gy
		end

		for gy = min_gy, max_gy, map_Y do

			local min_gx = 1
			local max_gx = #map[gz][gy]

			if map_X == -1 then
			
				min_gx, max_gx = max_gx, min_gx
			end

			for gx = min_gx, max_gx, map_X do

				v = map[gz][gy][gx]
--NEW ROTATION

				block_draw(gx, gy, gz, v)
			end
		end
	end
end

-- load default and update tiles geometry
function tile_update()

	zoom = zoom or 1

	factor_w = factor_w or 1
	factor_h = factor_h or 1
	factor_z = factor_z or 1

	tile_w = base_w * factor_w * zoom
	tile_h = base_h * factor_h * zoom
	tile_z = base_z * factor_z * zoom
end

-- modify tile geometry factors
function camera_rotate(d, dt)

	factor_w = factor_w + d * dt
	factor_h = factor_h + d * dt * 4
	factor_z = factor_z - d * dt / 4
	
	tile_update()
end


-- modify zoom
function camera_zoom(d, dt)

	zoom = zoom * (1 + d * dt)
	
	tile_update()
end

-- calculate every rhombi vectors
function rhombi(x, y)

	return
	
	x + tile_w, y + tile_z/2,
	x, y + tile_h + tile_z/2,
	x - tile_w, y + tile_z/2,
	x, y - tile_h + tile_z/2,
	
	x + tile_w, y - tile_z/2,
	x, y + tile_h - tile_z/2,
	x - tile_w, y - tile_z/2,
	x, y - tile_h - tile_z/2
end

function offset(x, y)

	-- store player draw coordinates
	local px, py = axono(

		player.gx,
		player.gy,
		player.gz
	)
	
	return

	-- center on player
	x + getW/2 - px,
	y + getH/2 - py
end

-- converse grid coordinates to axonometric draw
function axono(x, y, z)

	return
--NEW ROTATION
	(map_Y * x - map_X * y) * tile_w,
	(map_Y * y + map_X * x) * tile_h - z * tile_z
--NEW ROTATION
end

-- get draw coordinates
function block_getVertices(x, y, z)

	return rhombi(offset(axono(x, y, z)))
end

-- return v if value, else nil
function block_getValue(gx, gy, gz)

	return
	
	map[gz] and
	map[gz][gy] and
	map[gz][gy][gx]
end

-- return alpha if transparent, else nil
function block_getAlpha(v)

	return not v or colors[v][4]
end

-- return true if something is on screen
function onScreen(x0, y0, xW, yH)

	return

	x0 > 0 and xW < getW and
	y0 > 0 and yH < getH
end

-- get distance between the player and a block
function getDist(x, y, z)

	local dx, dy, dz =
	player.gx - x,
	player.gy - y,
	player.gz - z
	
	return math.sqrt(
	
		dx * dx +
		dy * dy +
		dz * dz
	)
end
