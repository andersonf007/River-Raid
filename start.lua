local widget =  require ("widget")
local composer = require ("composer")
local scene = composer.newScene()

local start

function scene:create(event)

	local grupoDeSena = self.view

	background = display.newImage("background.jpg")
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0
	background.y = 0
	grupoDeSena:insert(background)

	start = widget.newButton( {label="start", x = display.contentWidth/2, y = display.contentHeight/2 + 80, onPress = startar} )
	grupoDeSena:insert(start)
end

function startar(event)
	if event.phase == "began" then 
		composer.gotoScene("game")
	end
	if event.phase == "ended" then
		print("xau")
	end
end

function scene:show(event)
end

function scene:hide(event)
end

function scene:destroy(event)
end

scene:addEventListener( "create", scene ) -- adiciona o evento da funcao de criar 
scene:addEventListener( "show", scene ) -- adiciona o evento da funcao de entre 
scene:addEventListener( "hide", scene ) -- adiciona o evento da funcao de sair
scene:addEventListener( "destroy", scene )-- adiciona o evento da funcao de destruir 

return scene
