local composer = require ("composer")
local scene = composer.newScene()
local physics = require("physics")
	  physics.start()

local image
local left
local right
local motionX = 0

function scene:create(event)

		local groupScene = self.view

		image = display.newImage("ship.png")
		image.x = display.contentWidth/2
		image.y = display.contentHeight - 100
		image.speed = 2
		--physics.addBody( image, "dynamic", { friction=0.5, bounce=0 } )
		groupScene:insert(image)

		left = display.newRect( 0, 100, display.contentWidth/2, 400)
		left.anchorX = 0
		left.anchorY = 0
		--left.strokeWidth = 3
		left:setFillColor( 0,0,0,0.1)
		left:setStrokeColor( 1, 0, 0 )
		groupScene:insert(left)

		right = display.newRect( display.contentWidth/2, 100, display.contentWidth/2, 400)
		right.anchorX = 0
		right.anchorY = 0
		right.strokeWidth = 3
		right:setFillColor( 0,0,0,0.1)
		right:setStrokeColor( 1, 0, 0 )
		groupScene:insert(right)


		right:addEventListener("touch",MoverRight)
		left:addEventListener("touch",MoverLeft)
	--	Runtime:addEventListener("enterFrame", MoverRight)

end

function MoverRight(event)
	print("1")
	if event.phase == "began" then
  		image.x = image.x + 2
  	end
  	if event.phase =="ended" then
	   motionX = 0;
	end
end

function MoverLeft(event)
	print("2")
	if event.phase == "began" then
  		image.x = image.x - 2
  	end
  	if event.phase =="ended" then
	   motionX = 0;
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
