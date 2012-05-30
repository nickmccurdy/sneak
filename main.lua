require("donut/donut")
require("data")

function love.load()
	debugLoad()
	love.mouse.setVisible(false)
end

function love.update(dt)
	debugUpdate()
	for i = 1,1 do
		player[i].cursor.x = love.mouse.getX()
		player[i].cursor.y = love.mouse.getY()
		-- horizontal physics
			-- keyboard controls for acceleration/deceleration
			if not ( love.keyboard.isDown(binds.left) and love.keyboard.isDown(binds.right) ) then
				if love.keyboard.isDown(binds.left) then
					player[i].x_speed = player[i].x_speed - player[i].x_ACCEL
				elseif love.keyboard.isDown(binds.right) then
					player[i].x_speed = player[i].x_speed + player[i].x_ACCEL
				end
			end
			-- friction
			if player[i].x_speed > 0 then
				player[i].x_speed = player[i].x_speed - player[i].x_FRICTION
			elseif player[i].x_speed < 0 then
				player[i].x_speed = player[i].x_speed + player[i].x_FRICTION
			end
			-- max speed
			if player[i].x_speed > player[i].x_MAX_SPEED then
				player[i].x_speed = player[i].x_MAX_SPEED
			elseif player[i].x_speed < - player[i].x_MAX_SPEED then
				player[i].x_speed = - player[i].x_MAX_SPEED
			end
			-- player[i].x modification
			player[i].x = player[i].x + (dt * player[i].x_speed)
			-- player[i] direction display
			if player[i].x_speed < 0 then
				player[i].direction = "left"
			elseif player[i].x_speed > i then
				player[i].direction = "right"
			end
			-- edge collisions
			if player[i].x < 0 then
				player[i].x = 0
				if player[i].x_speed < 0 then
					player[i].x_speed = 0
				end
			elseif player[i].x > game.WIDTH - player[i].WIDTH then
				player[i].x = game.WIDTH - player[i].WIDTH
				if player[i].x_speed > 0 then
					player[i].x_speed = 0
				end
			end
		-- vertical physics
			-- keyboard controls for jumping
			if love.keyboard.isDown(binds.jump) and player[i].jumping_allowed then
				player[i].y_speed = 0 + player[i].y_JUMP_SPEED
				player[i].jumping_allowed = false
			end
			-- gravity
			player[i].y_speed = player[i].y_speed - player[i].y_GRAVITY
			-- player[i].y modification
			player[i].y = player[i].y - (dt* player[i].y_speed)
			-- edge collisions
			if player[i].y >= game.HEIGHT - player[i].HEIGHT then
				player[i].y = game.HEIGHT - player[i].HEIGHT
				player[i].y_speed = 0
				player[i].jumping_allowed = true
			end
		-- gun movement
			if player[i].direction == "left" then
				player[i].gun.x = player[i].x - player[i].gun.WIDTH - player[i].gun.OFFSET
				player[i].gun.y = player[i].y + player[i].HEIGHT/2 - player[i].gun.HEIGHT/2
			elseif player[i].direction == "right" then
				player[i].gun.x = player[i].x + player[i].WIDTH + player[i].gun.OFFSET
				player[i].gun.y = player[i].y + player[i].HEIGHT/2 - player[i].gun.HEIGHT/2
			end
		-- bullet movement
			if love.mouse.isDown("l") then
				player[i].bullet.direction = player[i].direction
				player[i].bullet.x = player[i].gun.x
				player[i].bullet.y = player[i].gun.y
				player[i].bullet.show = true
			end
			if player[i].bullet.show then
				if player[i].bullet.direction == "left" then
					player[i].bullet.x = player[i].bullet.x - player[i].bullet.SPEED
				elseif player[i].bullet.direction == "right" then
					player[i].bullet.x = player[i].bullet.x + player[i].bullet.SPEED
				end
			end
		-- projectile movement
			--for index,projectile in ipairs(player[i].projectiles) do
				-- move projectile based on its speed
			--end
	end
end

function love.draw()
	for i = 1,1 do
		--love.graphics.rectangle("line", player[i].x, player[i].y, player[i].WIDTH, player[i].HEIGHT)
		if player[i].direction == "left" then
			love.graphics.draw(player[i].IMAGE_LEFT, player[i].x, player[i].y)
			love.graphics.draw(player[i].gun.IMAGE_LEFT, player[i].gun.x, player[i].gun.y)
		elseif player[i].direction == "right" then
			love.graphics.draw(player[i].IMAGE_RIGHT, player[i].x, player[i].y)
			love.graphics.draw(player[i].gun.IMAGE_RIGHT, player[i].gun.x, player[i].gun.y)
		end
		if player[i].bullet.show then
			love.graphics.draw(player[i].bullet.IMAGE, player[i].bullet.x, player[i].bullet.y)
		end
		love.graphics.draw(player[i].cursor.IMAGE, player[i].cursor.x, player[i].cursor.y)
	end
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
