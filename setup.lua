gr = love.graphics
ke = love.keyboard
mo = love.mouse
ti = love.timer

require "engine"
require "colors"
require "draw"
require "player"
require "input"
require "map"
require "help"

function fullscreen()

	gr.setMode(0, 0)
	gr.toggleFullscreen()
end
