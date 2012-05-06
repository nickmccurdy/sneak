require("donut/donut")

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
	t.modules.joystick = false -- Enable the joystick module (boolean)
	t.modules.audio = false -- Enable the audio module (boolean)
	t.modules.keyboard = false -- Enable the keyboard module (boolean)
	t.modules.event = false -- Enable the event module (boolean)
	t.modules.image = false -- Enable the image module (boolean)
	t.modules.graphics = false -- Enable the graphics module (boolean)
	t.modules.timer = false -- Enable the timer module (boolean)
	t.modules.mouse = false -- Enable the mouse module (boolean)
	t.modules.sound = false -- Enable the sound module (boolean)
	t.modules.physics = false -- Enable the physics module (boolean)
end

function love.load()
	-- player data
	player = {
		-- position and dimensions
		x = 0,
		y = 510,
		width = 50,
		height = 90,
		-- media
		image_left = love.graphics.newImage("player_left.png"),
		image_right = love.graphics.newImage("player_right.png"),
		-- horizontal physics
		x_speed = 0,
		x_accel = 100,
		x_max_speed = 400,
		x_friction = 50,
		-- vertical physics
		y_speed = 0,
		y_jump_speed = 400,
		y_gravity = 200,
		-- other movement related stuff
		direction = "right",
		jumping_allowed = true,
		-- weapons
		projectiles = {},
		weapons = {}
	}
	-- data about the game window
	window = {
		width = 800,
		height = 600
	}
	-- debug
	debug = Donut.init(10, 10)
	debug_fps = debug.add("fps")
	debug_x_speed = debug.add("x speed")
	debug_x_accel = debug.add("x accel")
	debug_x_max_speed = debug.add("x max speed")
	debug_x_friction = debug.add("x friction")
	debug_y_speed = debug.add("y speed")
	debug_y_jump_speed = debug.add("y jump speed")
	debug_y_gravity = debug.add("y gravity")
end

function love.update(dt)
	debug.update(debug_fps, love.timer.getFPS())
	debug.update(debug_x_speed, player.x_speed)
	debug.update(debug_x_accel, player.x_accel)
	debug.update(debug_x_max_speed, player.x_max_speed)
	debug.update(debug_x_friction, player.x_friction)
	debug.update(debug_y_speed, player.y_speed)
	debug.update(debug_y_jump_speed, player.y_jump_speed)
	debug.update(debug_y_gravity, player.y_gravity)
	-- horizontal physics
		-- keyboard controls for acceleration/deceleration
		if not ( love.keyboard.isDown("left") and love.keyboard.isDown("right") ) then
			if love.keyboard.isDown("left") then
				player.x_speed = player.x_speed - player.x_accel
			elseif love.keyboard.isDown("right") then
				player.x_speed = player.x_speed + player.x_accel
			end
		end
		-- friction
		if player.x_speed > 0 then
			player.x_speed = player.x_speed - player.x_friction
		elseif player.x_speed < 0 then
			player.x_speed = player.x_speed + player.x_friction
		end
		-- player.x modification
		player.x = player.x + (dt * player.x_speed)
		-- player direction display
		if player.x_speed < 0 then
			player.direction = "left"
		elseif player.x_speed > 0 then
			player.direction = "right"
		end
		-- edge collisions
		if player.x < 0 then
			player.x = 0
			if player.x_speed < 0 then
				player.x_speed = 0
			end
		elseif player.x > window.width - player.width then
			player.x = window.width - player.width
			if player.x_speed > 0 then
				player.x_speed = 0
			end
		end
	-- vertical physics
		-- keyboard controls for jumping
		if love.keyboard.isDown("up") then
			player.y_speed = 0 - player.y_jump_speed
		end
		-- gravity
		player.y_speed = player.y_speed - player.y_gravity
		-- player.y modification
		player.y = player.y - (dt* player.y_speed)
		-- edge collisions
		if player.y >= window.height - player.height then
			player.y = window.height - player.height
		end
	-- projectile movement
		--for index,projectile in ipairs(player.projectiles) do
			-- move projectile based on its speed
		--end
end

function love.draw()
	--love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
	if player.direction == "left" then
		love.graphics.draw(player.image_left, player.x, player.y, player.rotation)
	elseif player.direction == "right" then
		love.graphics.draw(player.image_right, player.x, player.y, player.rotation)
	end
	debug.draw()
end

function love.mousepressed()
end

function love.mousereleased()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
	if key == "space" then
		debug.toggle()
	end
end

function love.keyreleased()
end

function love.focus()
end

function love.quit()
end
