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
		WIDTH = 50,
		HEIGHT = 90,
		-- media
		IMAGE_LEFT = love.graphics.newImage("img/player_left.png"),
		IMAGE_RIGHT = love.graphics.newImage("img/player_right.png"),
		-- horizontal physics
		x_speed = 0,
		x_ACCEL = 100,
		x_MAX_SPEED = 800,
		x_FRICTION = 50,
		-- vertical physics
		y_speed = 0,
		y_JUMP_SPEED = 800,
		y_GRAVITY = 30,
		-- other movement related stuff
		direction = "right",
		jumping_allowed = true,
		-- weapons
		gun = {
			--position and dimensions
			x = 0,
			y = 0,
			OFFSET = 20,
			WIDTH = 35,
			HEIGHT = 50,
			-- media
			IMAGE_LEFT = love.graphics.newImage("img/gun_left.png"),
			IMAGE_RIGHT = love.graphics.newImage("img/gun_right.png")
		},
		bullet = {
			--position and dimensions
			x = 0,
			y = 0,
			WIDTH = 50,
			HEIGHT = 35,
			-- horizontal physics
			SPEED = 1000,
			-- media
			IMAGE = love.graphics.newImage("img/bullet.png"),
			-- other
			show = false,
			direction = "right"
		}
	}
	-- data about the game
	game = {
		WIDTH = 800,
		HEIGHT = 600
	}
	-- debug
	debug = Donut.init(10, 10)
	debug_fps = debug.add("fps")
	debug_x = debug.add("x")
	debug_y = debug.add("y")
	debug_x_speed = debug.add("x speed")
	debug_y_speed = debug.add("y speed")
	debug_x_accel = debug.add("x accel")
	debug_x_max_speed = debug.add("x max speed")
	debug_x_friction = debug.add("x friction")
	debug_y_jump_speed = debug.add("y jump speed")
	debug_y_gravity = debug.add("y gravity")
end

function love.update(dt)
	debug.update(debug_fps, love.timer.getFPS())
	debug.update(debug_x, player.x)
	debug.update(debug_y, player.y)
	debug.update(debug_x_speed, player.x_speed)
	debug.update(debug_y_speed, player.y_speed)
	debug.update(debug_x_accel, player.x_ACCEL)
	debug.update(debug_x_max_speed, player.x_MAX_SPEED)
	debug.update(debug_x_friction, player.x_FRICTION)
	debug.update(debug_y_jump_speed, player.y_JUMP_SPEED)
	debug.update(debug_y_gravity, player.y_GRAVITY)
	-- horizontal physics
		-- keyboard controls for acceleration/deceleration
		if not ( love.keyboard.isDown("left") and love.keyboard.isDown("right") ) then
			if love.keyboard.isDown("left") then
				player.x_speed = player.x_speed - player.x_ACCEL
			elseif love.keyboard.isDown("right") then
				player.x_speed = player.x_speed + player.x_ACCEL
			end
		end
		-- friction
		if player.x_speed > 0 then
			player.x_speed = player.x_speed - player.x_FRICTION
		elseif player.x_speed < 0 then
			player.x_speed = player.x_speed + player.x_FRICTION
		end
		-- max speed
		if player.x_speed > player.x_MAX_SPEED then
			player.x_speed = player.x_MAX_SPEED
		elseif player.x_speed < - player.x_MAX_SPEED then
			player.x_speed = - player.x_MAX_SPEED
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
		elseif player.x > game.WIDTH - player.WIDTH then
			player.x = game.WIDTH - player.WIDTH
			if player.x_speed > 0 then
				player.x_speed = 0
			end
		end
	-- vertical physics
		-- keyboard controls for jumping
		if love.keyboard.isDown("up") and player.jumping_allowed then
			player.y_speed = 0 + player.y_JUMP_SPEED
			player.jumping_allowed = false
		end
		-- gravity
		player.y_speed = player.y_speed - player.y_GRAVITY
		-- player.y modification
		player.y = player.y - (dt* player.y_speed)
		-- edge collisions
		if player.y >= game.HEIGHT - player.HEIGHT then
			player.y = game.HEIGHT - player.HEIGHT
			player.y_speed = 0
			player.jumping_allowed = true
		end
	-- gun movement
		if player.direction == "left" then
			player.gun.x = player.x - player.gun.WIDTH - player.gun.OFFSET
			player.gun.y = player.y + player.HEIGHT/2 - player.gun.HEIGHT/2
		elseif player.direction == "right" then
			player.gun.x = player.x + player.WIDTH + player.gun.OFFSET
			player.gun.y = player.y + player.HEIGHT/2 - player.gun.HEIGHT/2
		end
	-- bullet movement
		if love.keyboard.isDown("space") then
			player.bullet.direction = player.direction
			player.bullet.x = player.gun.x
			player.bullet.y = player.gun.y
			player.bullet.show = true
		end
		if player.bullet.show then
			if player.bullet.direction == "left" then
				player.bullet.x = player.bullet.x - player.bullet.SPEED
			elseif player.bullet.direction == "right" then
				player.bullet.x = player.bullet.x + player.bullet.SPEED
			end
		end
	-- projectile movement
		--for index,projectile in ipairs(player.projectiles) do
			-- move projectile based on its speed
		--end
end

function love.draw()
	--love.graphics.rectangle("line", player.x, player.y, player.WIDTH, player.HEIGHT)
	if player.direction == "left" then
		love.graphics.draw(player.IMAGE_LEFT, player.x, player.y)
		love.graphics.draw(player.gun.IMAGE_LEFT, player.gun.x, player.gun.y)
	elseif player.direction == "right" then
		love.graphics.draw(player.IMAGE_RIGHT, player.x, player.y)
		love.graphics.draw(player.gun.IMAGE_RIGHT, player.gun.x, player.gun.y)
	end
	if player.bullet.show then
		love.graphics.draw(player.bullet.IMAGE, player.bullet.x, player.bullet.y)
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
