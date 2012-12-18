function love.draw()
	for _, player in ipairs(players) do
		--love.graphics.rectangle("line", player.x, player.y, player.WIDTH, player.HEIGHT)
		if player.direction == "left" then
			love.graphics.draw(player.IMAGE_LEFT, player.x, player.y)
			for _, weapon in pairs(player.weapons) do
				love.graphics.draw(weapon.IMAGE_LEFT, weapon.x, weapon.y)
			end
		elseif player.direction == "right" then
			love.graphics.draw(player.IMAGE_RIGHT, player.x, player.y)
			for _, weapon in pairs(player.weapons) do
				love.graphics.draw(weapon.IMAGE_RIGHT, weapon.x, weapon.y)
			end
		end
		for _, projectile in pairs(player.projectiles) do
			if projectile.show then
				love.graphics.draw(projectile.IMAGE, projectile.x, projectile.y)
			end
		end
		love.graphics.draw(player.cursor.IMAGE, player.cursor.x, player.cursor.y)
	end
	debug.draw()
end
