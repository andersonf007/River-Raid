local composer = require ("composer")
local scene = composer.newScene()
local physics = require("physics")
	  physics.start()

local image
local left
local right
local motionX = 0
local estrada1

function scene:create(event)

		local groupScene = self.view


		estrada1 = display.newImage("estrada.png")
		--estrada1.anchorX = 0
		--estrada1.anchorY = 0
		estrada1.x = display.contentWidth/2
		estrada1.y = 250
		estrada1.speed = 2
		groupScene:insert(estrada1)

		estrada2 = display.newImage("estrada.png")
		--estrada2.anchorX = 0
		--estrada2.anchorY = 0
		estrada2.x = display.contentWidth/2
		estrada2.y = - 250
		estrada2.speed = 2
		groupScene:insert(estrada2)

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
		--right.strokeWidth = 3
		right:setFillColor( 0,0,0,0.1)
		right:setStrokeColor( 1, 0, 0 )
		groupScene:insert(right)


		right:addEventListener("touch",MoverRight)
		left:addEventListener("touch",MoverLeft)

	estrada1.enterFrame = rolagemDaEstrada 
	Runtime:addEventListener("enterFrame",estrada1)

	estrada2.enterFrame = rolagemDaEstrada 
	Runtime:addEventListener("enterFrame",estrada2)
end

function MoverRight(event)
	--print("1")
	if event.phase == "began" then
  		image.x = image.x + 10
  	end
  	if event.phase =="ended" then
	   motionX = 0;
	end
end

function MoverLeft(event)
--	print("2")
	if event.phase == "began" then
  		image.x = image.x - 5
  	end
  	if event.phase =="ended" then
	   motionX = 0;
	end
end

function rolagemDaEstrada(event)
	if event.y > 725 then--condicao pra quando o x = 385 adicionar a imagem da cidade a tras na posicao 400
	   event.y = - 250
	else
	    event.y =  event.y + event.speed --pega avelocidade de cada cidade 
	   -- cada cidade vai levar uns 30 segundos passando pela tela
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
