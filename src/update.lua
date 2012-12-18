function love.update(dt)
	debugUpdate()
	for _, player in ipairs(players) do
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
				player.weapons.gun.x = player.x - player.weapons.gun.WIDTH - player.weapons.gun.OFFSET
				player.weapons.gun.y = player.y + player.HEIGHT/2 - player.weapons.gun.HEIGHT/2
			elseif player.direction == "right" then
				player.weapons.gun.x = player.x + player.WIDTH + player.weapons.gun.OFFSET
				player.weapons.gun.y = player.y + player.HEIGHT/2 - player.weapons.gun.HEIGHT/2
			end
		-- bullet movement
			if love.mouse.isDown("l") and not player.projectiles.bullet.show then
				player.projectiles.bullet.direction = player.direction
				player.projectiles.bullet.x = player.weapons.gun.x
				player.projectiles.bullet.y = player.weapons.gun.y
				player.projectiles.bullet.show = true
			end
			if player.projectiles.bullet.show then
				if player.projectiles.bullet.x + player.projectiles.bullet.WIDTH < 0 or player.projectiles.bullet.x > game.WIDTH then
					player.projectiles.bullet.show = false
					else
					if player.projectiles.bullet.direction == "left" then
						player.projectiles.bullet.x = player.projectiles.bullet.x - player.projectiles.bullet.SPEED
					elseif player.projectiles.bullet.direction == "right" then
						player.projectiles.bullet.x = player.projectiles.bullet.x + player.projectiles.bullet.SPEED
					end
				end
			end
		-- projectile movement
			--for index,projectile in ipairs(player.projectiles) do
				-- move projectile based on its speed
			--end
	end
end
