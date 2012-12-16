-- 3rd party libraries
require("donut/donut")

-- additional game code
require("data")
require("update")
require("draw")
require("events")

function love.load()
	debugLoad()
	love.mouse.setVisible(false)
	table.insert(players,player_template)
end

function love.focus()
end

function love.quit()
end
