function love.load()

	require "setup"

--	fullscreen()
	engine_init()
end

function love.update(dt)

	input_stream(dt)
end

function love.draw()

	engine_run()
	print_help()
end

function love.keypressed(key)

	input_keypressed(key)
end
