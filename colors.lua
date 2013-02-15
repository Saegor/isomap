colors = {

	empty =
	{0x00, 0x00, 0x00, 0x00};
	ground =
	{0x20, 0x30, 0x60};
	grass =
	{0x50, 0x40, 0x70};
	leaf =
	{0x60, 0x40, 0x70};
	stone =
	{0x00, 0x00, 0x90};
	water =
	{0x90, 0x70, 0x60, 0x80};
	wood =
	{0x28, 0x30, 0x60};
	sky =
	{0x80, 0x40, 0x60};
	player =
	{0x80, 0x60, 0x60};
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
	
	local r =
	h < 1 and c or
	h < 2 and x or
	h < 4 and 0 or
	h < 5 and x or c
	
	local g =
	h < 1 and x or
	h < 3 and c or
	h < 4 and x or 0
		
	local b =
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
	
	local h, s, l, alpha = unpack(colors[value])

	-- lighting	
	l = l * (1 - dist/0x10)
	l = l * (1 + angle/0x8)

	local r, g, b = hsl(h, s, l)

	gr.setColor(r, g, b, alpha)
end
