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
