require("donut/donut")
require("data")

function love.load()
	debugLoad()
	love.mouse.setVisible(false)
end

function love.update(dt)
	debugUpdate()
	player.cursor.x = love.mouse.getX()
	player.cursor.y = love.mouse.getY()
	-- horizontal physics
		-- keyboard controls for acceleration/deceleration
		if not ( love.keyboard.isDown(binds.left) and love.keyboard.isDown(binds.right) ) then
			if love.keyboard.isDown(binds.left) then
				player.x_speed = player.x_speed - player.x_ACCEL
			elseif love.keyboard.isDown(binds.right) then
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
		if love.keyboard.isDown(binds.jump) and player.jumping_allowed then
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
		if love.mouse.isDown("l") then
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
	love.graphics.draw(player.cursor.IMAGE, player.cursor.x, player.cursor.y)
	debug.draw()
end

function love.mousepressed()
end

function love.mousereleased()
end

function love.keypressed(key)
	if key == binds.quit then
		love.event.push("quit")
	end
end

function love.keyreleased()
end

function love.focus()
end

function love.quit()
end
