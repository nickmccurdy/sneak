require("donut")

function love.load()
	debug = Donut.init(10, 10)
	fps = debug.add("FPS")
	random = debug.add("Random")
end

function love.update(dt)
	debug.update(fps, love.timer.getFPS())
	debug.update(random, math.random(0, 100))
end

function love.keypressed(key, unicode)
	if key == "s" then -- show/hide with "s"
		debug.toggle()
	end
end

function love.draw()
	debug.draw()
	-- you could also use debug.draw(xoffset, yoffset) to move the message if you're using a cam
end