function engine_init()

	-- set background
	gr.setBackgroundColor(hsl(unpack(colors.sky)))

	-- set font size
	gr.setFont(gr.newFont(16))

	-- set tile size
	base_w = 0x20 --* math.sqrt(3)/2
	base_h = 0x10
	base_z = 0x10

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
				
		for gy in ipairs(map[gz]) do

			for gx, v in pairs(map[gz][gy]) do
				
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
	
	x + tile_w, y + tile_z,
	x, y + tile_h + tile_z,
	x - tile_w, y + tile_z,
	x, y - tile_h + tile_z,
	
	x + tile_w, y - tile_z,
	x, y + tile_h - tile_z,
	x - tile_w, y - tile_z,
	x, y - tile_h - tile_z
end

function offset(x, y)

	-- take player location into account
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

-- make an axonometry
function axono(x, y, z)

	return

	(x - y) * tile_w,
	(x + y) * tile_h - (z + z) * tile_z
end

-- get draw coordinates
function block_getVertices(x, y, z)

	return rhombi(offset(axono(x, y, z)))
end

-- return nil if no value/no row/no column
function block_getValue(gx, gy, gz)

	return
	
	map[gz] and
	map[gz][gy] and
	map[gz][gy][gx]
end

-- return false if not transparent
function block_getAlpha(v)

	return not v or colors[v][4]
end

-- check if something is on screen
function onScreen(xa, ya, xb, yb)

	return

	xa > 0 and xb < getW and
	ya > 0 and yb < getH
end

-- get distance between the player and a block
function getDist(x, y, z)

	local dx, dy, dz =
	player.gx - x,
	player.gy - y,
	player.gz - z
	
	--[[-- TEST sun
	tx = tx and tx + .0001 or -4
	ty = ty and ty + .0001 or -4
	tz = tz or 8
	
	local dx, dy, dz =
	tx - x,
	ty - y,
	tz - z
	--]]-- TEST
	
	return math.sqrt(
	
		dx * dx +
		dy * dy +
		dz * dz
	)
end
