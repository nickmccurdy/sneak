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
	},
	cursor = {
		x = 0,
		y = 0,
		IMAGE = love.graphics.newImage("img/crosshair.png")
	}
}

-- data about the game
game = {
	WIDTH = 800,
	HEIGHT = 600
}

-- key bindings (controls)
binds = {
	left = "left",
	right = "right",
	jump = "up",
	fire = "space",
	quit = "escape"
}

function debugLoad()
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

function debugUpdate()
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
end
