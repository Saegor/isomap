colors = {

	empty =
	{0x00, 0x00, 0x00, 0x00};
	ground =
	{0x20, 0x40, 0x40};
	grass =
	{0x50, 0x50, 0x50};
	leaf =
	{0x60, 0x50, 0x50};
	stone =
	{0x00, 0x00, 0x60};
	water =
	{0x90, 0x70, 0x60, 0x80};
	wood =
	{0x20, 0x40, 0x40};
	sky_sun =
	{0x80, 0x30, 0x60};
	sky_night =
	{0x80, 0x00, 0x10};
	player =
	{0x80, 0x10, 0x60};
	unknown =
	{0x00, 0xFF, 0x80, 0x80};
}

function hsl(h, s, l)

	-- return black or white
	if l < 0x00 then return 0x00, 0x00, 0x00 end
	if l > 0xFF then return 0xFF, 0xFF, 0xFF end

	-- return grey if no saturation
	if s < 0 then return l, l, l end

	h = h/0x100 * 6
	s = s/0x100
	l = l/0x100
	
	h = h > 0 and h < 6 and h or h % 6
	s = s > 1 and 1 or s

	local c = s * (1 - math.abs(2 * l - 1))
	
	local x = c * (1 - math.abs(h % 2 - 1))
	
	local r, g, b =

	h < 1 and c or
	h < 2 and x or
	h < 4 and 0 or
	h < 5 and x or c,
	
	h < 1 and x or
	h < 3 and c or
	h < 4 and x or 0,
		
	h < 2 and 0 or
	h < 3 and x or
	h < 5 and c or x
	
	local m = l - c/2
	
	return
	
	0xFF * (r + m),
	0xFF * (g + m),
	0xFF * (b + m)
end

function face_setColor(value, dist, angle)
	
	-- extract the colors from the table
	local h, s, l, alpha = unpack(colors[value])

	-- round, or something similar
--	dist = math.floor(dist^.5)^2

	-- create a field of view
	l = l * (1 - dist/0xA)

	-- desature out of view
	s = s * (1 - dist/0xA)

	-- drop shadows under things
	l = l * (1 + angle/0x4)
		
	-- choose a minimum cap of light
	l = l > 0x10 and l or 0x10
	-- YOU GOT THE CAP OF LIGHT

	-- collect and format
	local r, g, b = hsl(h, s, l)

	-- setColor
	gr.setColor(r, g, b, alpha)
end
