function love.draw()
	for _, player in pairs(players) do
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
	end
	debug.draw()
end
