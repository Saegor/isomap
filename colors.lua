colors = {

	empty =
	{0x00, 0x00, 0x00, 0x00};
	ground =
	{0x20, 0x20, 0x80};
	grass =
	{0x50, 0x20, 0x80};
	leaf =
	{0x60, 0x30, 0x70};
	stone =
	{0x00, 0x00, 0x90};
	water =
	{0x90, 0x60, 0x60, 0x80};
	wood =
	{0x28, 0x20, 0x60};
	sky =
	{0x88, 0x20, 0x80};
	player =
	{0x00, 0x00, 0xA0, 0x80};
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

function face_setColor(value, angle, dist)
	
	local h, s, l, a = unpack(colors[value])

	--[[-- TEST light aura
	if dist then

		if angle then
		angle = angle + (0 - angle)/(4 + dist)
		end
		
		h = h + (0x28 - h)/(2 + dist)

--		if s ~= 0 then
--		s = s + (0xFF - s)/(2 + dist)
--		end
		
		l = l + (0xC0 - l)/(2 + dist)
	end
	--]]-- TEST
	
	-- shadows
	l = angle and l - angle * l/0x8 or l

	-- field of view
	l = dist and l - dist * l/0x10 or l	

	--TEST
--	l = dist and math.floor(l/8)*8 or l

	local r, g, b = hsl(h, s, l)

	gr.setColor(r, g, b, a)
end
