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
				for _, weapon in pairs(player.weapons) do
					weapon.x = player.x - weapon.WIDTH - weapon.OFFSET
					weapon.y = player.y + player.HEIGHT/2 - weapon.HEIGHT/2
				end
			elseif player.direction == "right" then
				for _, weapon in pairs(player.weapons) do
					weapon.x = player.x + player.WIDTH + weapon.OFFSET
					weapon.y = player.y + player.HEIGHT/2 - weapon.HEIGHT/2
				end
			end
		-- bullet movement
			for _, projectile in pairs(player.projectiles) do
				if love.mouse.isDown("l") and not projectile.show then
					projectile.direction = player.direction
					print(projectile.weapon)
					projectile.x = player.weapons[projectile.weapon].x
					projectile.y = player.weapons[projectile.weapon].y
					projectile.show = true
				end
				if projectile.show then
					if projectile.x + projectile.WIDTH < 0 or projectile.x > game.WIDTH then
						projectile.show = false
						else
						if projectile.direction == "left" then
							projectile.x = projectile.x - projectile.SPEED
						elseif projectile.direction == "right" then
							projectile.x = projectile.x + projectile.SPEED
						end
					end
				end
			end
		-- projectile movement
			--for index,projectile in ipairs(player.projectiles) do
				-- move projectile based on its speed
			--end
	end
end
