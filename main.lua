-- 3rd party libraries
require("lib/donut/donut")

-- additional game code
require("src/data")
require("src/update")
require("src/draw")
require("src/events")

function love.load()
	debugLoad()
	love.mouse.setVisible(false)
	table.insert(players,player_template)
end

function love.focus()
end

function love.quit()
end
