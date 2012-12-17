function love.draw()
	for i = 1,#players do
		--love.graphics.rectangle("line", players[i].x, players[i].y, players[i].WIDTH, players[i].HEIGHT)
		if players[i].direction == "left" then
			love.graphics.draw(players[i].IMAGE_LEFT, players[i].x, players[i].y)
			love.graphics.draw(players[i].gun.IMAGE_LEFT, players[i].gun.x, players[i].gun.y)
		elseif players[i].direction == "right" then
			love.graphics.draw(players[i].IMAGE_RIGHT, players[i].x, players[i].y)
			love.graphics.draw(players[i].gun.IMAGE_RIGHT, players[i].gun.x, players[i].gun.y)
		end
		if players[i].bullet.show then
			love.graphics.draw(players[i].bullet.IMAGE, players[i].bullet.x, players[i].bullet.y)
		end
		love.graphics.draw(players[i].cursor.IMAGE, players[i].cursor.x, players[i].cursor.y)
	end
	debug.draw()
end
