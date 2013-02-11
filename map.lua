function map_load(map_string)

	-- declare map table and counters
	local map, gx, gy = {}

	-- for each level
	for gz in ipairs(map_string) do
	
		-- reinit counter, fill map table
		gy = 1 ; map[gz] = {}
		
		-- for each line (exclude tab and return)
		for this_line in map_string[gz]:gmatch("[^\t\n]+") do

			-- reinit counter, fill map table
			gx = 1 ; map[gz][gy] = {}
			
			-- for each character
			for this_char in this_line:gmatch(".") do

				-- converse from char to number
				map[gz][gy][gx] = map_converse(this_char)
				
				-- go to next colomn
				gx = gx + 1
			end

			-- go to next row
			gy = gy + 1
		end
	end
	
	return map
end

function map_rotate(cw)
		
	-- declare a temp map table
	local map_tmp = {}

	-- for each level
	for gz in ipairs(map) do
	
		-- store the max number or rows
		local max_dim = math.max(max_dim or 0, #map[gz])

		-- for each row
		for gy in ipairs(map[gz]) do

			-- store the max number of columns
			max_dim = math.max(max_dim, #map[gz][gy])
		end

		-- try to update player location
		if player.gz == gz then

			player.gx, player.gy =
			cw and max_dim + 1 - player.gy or player.gy,
			cw and player.gx or max_dim + 1 - player.gx		
		end
	
		-- make some subtables
		map_tmp[gz] = {}

		-- for each needed rows
		for gy = 1, max_dim do
		
			-- create a subtable
			map_tmp[gz][gy] = {}
		end

		-- for each created rows
		for gy in ipairs(map[gz]) do

			-- for each cell
			for gx, v in pairs(map[gz][gy]) do

				-- rotate
				local gx_rot, gy_rot =
				cw and max_dim + 1 - gy or gy,
				cw and gx or max_dim + 1 - gx

				map_tmp[gz][gy_rot][gx_rot] = v
			end
		end
	end
	
	-- return rotated map
	return map_tmp
end

function map_converse(char)

	return
	
	char == "_" and "empty" or
	char == "." and "ground" or
	char == "%" and "leaf" or
	char == "#" and "stone" or
	char == "~" and "water" or
	char == "$" and "wood" or
	"unknown"
end
