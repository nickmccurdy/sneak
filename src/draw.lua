function love.draw()
	for _, player in ipairs(players) do
		--love.graphics.rectangle("line", player.x, player.y, player.WIDTH, player.HEIGHT)
		if player.direction == "left" then
			love.graphics.draw(player.IMAGE_LEFT, player.x, player.y)
			love.graphics.draw(player.weapons.gun.IMAGE_LEFT, player.weapons.gun.x, player.weapons.gun.y)
		elseif player.direction == "right" then
			love.graphics.draw(player.IMAGE_RIGHT, player.x, player.y)
			love.graphics.draw(player.weapons.gun.IMAGE_RIGHT, player.weapons.gun.x, player.weapons.gun.y)
		end
		if player.projectiles.bullet.show then
			love.graphics.draw(player.projectiles.bullet.IMAGE, player.projectiles.bullet.x, player.projectiles.bullet.y)
		end
		love.graphics.draw(player.cursor.IMAGE, player.cursor.x, player.cursor.y)
	end
	debug.draw()
end
