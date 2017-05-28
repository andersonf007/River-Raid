local composer = require ("composer")
local widget = require( "widget" )
local game = require ("game")
local scene = composer.newScene()

local labelGameOver
local buttonRestart

function scene:create(event)
	
   local grupoDeSena = self.view

   labelGameOver = display.newText({text="Game Over", x=display.contentWidth/2, y = display.contentHeight/2 - 23})
   grupoDeSena:insert(labelGameOver)

   buttonRestart = widget.newButton({label = "restart", x = display.contentWidth/2, y = display.contentHeight/2 + 80, onPress = irOutroTela})
   grupoDeSena:insert(buttonRestart)
   
end

function irOutroTela(event)
	if event.phase == "began" then
		startEnemy()
		startGame()
		composer.gotoScene("game")
	end
end

function scene:show(event)
	-- body
end

function scene:hide(event)
	-- body
end

function scene:destroy(event)
	-- body
end
scene:addEventListener( "create", scene ) -- adiciona o evento da funcao de criar 
scene:addEventListener( "show", scene ) -- adiciona o evento da funcao de entre 
scene:addEventListener( "hide", scene ) -- adiciona o evento da funcao de sair
scene:addEventListener( "destroy", scene )-- adiciona o evento da funcao de destruir 

return scene