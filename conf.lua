function love.conf(t)

	t.title = "Isömap 0.094"
	t.author = "Saegor"
	t.version = "0.8.0"
	t.url = nil
	t.identity = nil
	t.release = false

	t.screen.width = 640
	t.screen.height = 480
	t.screen.fullscreen = false
	t.screen.vsync = true
	t.screen.fsaa = 0

	t.modules.timer = true
	t.modules.keyboard = true
	t.modules.event = true
	t.modules.graphics = true
	t.modules.mouse = true

	t.modules.image = false
	t.modules.audio = false
	t.modules.sound = false
	t.modules.joystick = false
	t.modules.physics = false
end
