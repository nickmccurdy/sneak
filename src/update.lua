function love.update(dt)
	debugUpdate()
	for i = 1,#players do
		players[i].cursor.x = love.mouse.getX()
		players[i].cursor.y = love.mouse.getY()
		-- horizontal physics
			-- keyboard controls for acceleration/deceleration
			if not ( love.keyboard.isDown(binds.left) and love.keyboard.isDown(binds.right) ) then
				if love.keyboard.isDown(binds.left) then
					players[i].x_speed = players[i].x_speed - players[i].x_ACCEL
				elseif love.keyboard.isDown(binds.right) then
					players[i].x_speed = players[i].x_speed + players[i].x_ACCEL
				end
			end
			-- friction
			if players[i].x_speed > 0 then
				players[i].x_speed = players[i].x_speed - players[i].x_FRICTION
			elseif players[i].x_speed < 0 then
				players[i].x_speed = players[i].x_speed + players[i].x_FRICTION
			end
			-- max speed
			if players[i].x_speed > players[i].x_MAX_SPEED then
				players[i].x_speed = players[i].x_MAX_SPEED
			elseif players[i].x_speed < - players[i].x_MAX_SPEED then
				players[i].x_speed = - players[i].x_MAX_SPEED
			end
			-- players[i].x modification
			players[i].x = players[i].x + (dt * players[i].x_speed)
			-- players[i] direction display
			if players[i].x_speed < 0 then
				players[i].direction = "left"
			elseif players[i].x_speed > 0 then
				players[i].direction = "right"
			end
			-- edge collisions
			if players[i].x < 0 then
				players[i].x = 0
				if players[i].x_speed < 0 then
					players[i].x_speed = 0
				end
			elseif players[i].x > game.WIDTH - players[i].WIDTH then
				players[i].x = game.WIDTH - players[i].WIDTH
				if players[i].x_speed > 0 then
					players[i].x_speed = 0
				end
			end
		-- vertical physics
			-- keyboard controls for jumping
			if love.keyboard.isDown(binds.jump) and players[i].jumping_allowed then
				players[i].y_speed = 0 + players[i].y_JUMP_SPEED
				players[i].jumping_allowed = false
			end
			-- gravity
			players[i].y_speed = players[i].y_speed - players[i].y_GRAVITY
			-- players[i].y modification
			players[i].y = players[i].y - (dt* players[i].y_speed)
			-- edge collisions
			if players[i].y >= game.HEIGHT - players[i].HEIGHT then
				players[i].y = game.HEIGHT - players[i].HEIGHT
				players[i].y_speed = 0
				players[i].jumping_allowed = true
			end
		-- gun movement
			if players[i].direction == "left" then
				players[i].gun.x = players[i].x - players[i].gun.WIDTH - players[i].gun.OFFSET
				players[i].gun.y = players[i].y + players[i].HEIGHT/2 - players[i].gun.HEIGHT/2
			elseif players[i].direction == "right" then
				players[i].gun.x = players[i].x + players[i].WIDTH + players[i].gun.OFFSET
				players[i].gun.y = players[i].y + players[i].HEIGHT/2 - players[i].gun.HEIGHT/2
			end
		-- bullet movement
			if love.mouse.isDown("l") and not players[i].bullet.show then
				players[i].bullet.direction = players[i].direction
				players[i].bullet.x = players[i].gun.x
				players[i].bullet.y = players[i].gun.y
				players[i].bullet.show = true
			end
			if players[i].bullet.show then
				if players[i].bullet.x + players[i].bullet.WIDTH < 0 or players[i].bullet.x > game.WIDTH then
					players[i].bullet.show = false
				else
					if players[i].bullet.direction == "left" then
						players[i].bullet.x = players[i].bullet.x - players[i].bullet.SPEED
					elseif players[i].bullet.direction == "right" then
						players[i].bullet.x = players[i].bullet.x + players[i].bullet.SPEED
					end
				end
			end
		-- projectile movement
			--for index,projectile in ipairs(players[i].projectiles) do
				-- move projectile based on its speed
			--end
	end
end
