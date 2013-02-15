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

--NEW ROTATION 60%
	cw = cw and 1 or -1

	map_X, map_Y =
	map_Y * - cw,
	map_X * cw 
--NEW ROTATION
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
