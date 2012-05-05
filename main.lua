function love.conf(t)
	-- Basic information
	t.title = "Sneak" -- The title of the window the game is in (string)
	t.author = "Nicolas McCurdy" -- The author of the game (string)
	t.identity = nil -- The name of the save directory (string)
	t.version = "0.8.0" -- The LÖVE version this game was made for (string)
	t.console = false -- Attach a console (boolean, Windows only)
	t.release = false -- Enable release mode (boolean)
	t.screen.width = 800 -- The window width (number)
	t.screen.height = 600 -- The window height (number)
	t.screen.fullscreen = false -- Enable fullscreen (boolean)
	t.screen.vsync = true -- Enable vertical sync (boolean)
	t.screen.fsaa = 0 -- The number of FSAA-buffers (number)
	-- Modules
	t.modules.joystick = true -- Enable the joystick module (boolean)
	t.modules.audio = true -- Enable the audio module (boolean)
	t.modules.keyboard = true -- Enable the keyboard module (boolean)
	t.modules.event = true -- Enable the event module (boolean)
	t.modules.image = true -- Enable the image module (boolean)
	t.modules.graphics = true -- Enable the graphics module (boolean)
	t.modules.timer = true -- Enable the timer module (boolean)
	t.modules.mouse = true -- Enable the mouse module (boolean)
	t.modules.sound = true -- Enable the sound module (boolean)
	t.modules.physics = true -- Enable the physics module (boolean)
end

function love.load()
	player = {
		x = 0,
		y = 500,
		width = 50,
		height = 100,
		speed = 400,
		jumping = false,
		jumping_allowed = false,
		projectiles = {},
		weapons = {}
	}
	gravity = 200
end

function love.update(dt)
	-- left/right movement
	if love.keyboard.isDown("left") and player.x >= 0 then
		player.x = player.x - (dt * player.speed)
	end
	if love.keyboard.isDown("right") and player.x <= 800-player.width then
		player.x = player.x + (dt * player.speed)
	end
	-- left/right edge collision fixes
	if player.x < 0 then
		player.x = 0
	end
	if player.x > 800-player.width then
		player.x = 800-player.width
	end
	-- jumping
	if love.keyboard.isDown("up") and player.jumping_allowed == true then
		player.jumping = true
	end
	if player.jumping == true then
		player.jumping_allowed = false
		if player.y > 300 then
			player.y = player.y - (dt * player.speed)
		else
			player.jumping = false
		end
	end
	-- gravity
	player.y = player.y + (dt * gravity)
	if player.y >= 600-player.height then
		player.y = 600-player.height
		player.jumping_allowed = true
	end
	-- projectile movement
	--for index,projectile in ipairs(player.projectiles) do
		-- move projectile based on its speed
	--end
end

function love.draw()
	love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
end

function love.mousepressed()
end

function love.mousereleased()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end

function love.keyreleased()
end

function love.focus()
end

function love.quit()
end
