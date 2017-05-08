local widget = require( "widget" )
local composer = require ("composer")
local scene = composer.newScene()
local physics = require("physics")
	  physics.start()

local image
local left
local right
local motionX = 0
local estrada1
local estrada2
local quadrado
local flag = 1
local ButtonFire

function scene:create(event)

		local groupScene = self.view

		estrada1 = display.newImage("estrada.png")--a primeira estrada
		estrada1.x = display.contentWidth/2
		estrada1.y = 250
		estrada1.speed = 2
		groupScene:insert(estrada1)

		estrada2 = display.newImage("estrada.png")--a segunda estrada a que fica atras da tela
		estrada2.x = display.contentWidth/2
		estrada2.y = - 250
		estrada2.speed = 2
		groupScene:insert(estrada2)

		image = display.newImage("ship.png")--imagem da nave
		image.x = display.contentWidth/2
		image.y = display.contentHeight - 100
		image.speed = 2
		physics.setGravity(0,0)
		physics.addBody( image, "static" ,{friction = 1, bounce = 0} )
		groupScene:insert(image)

	--[[left = display.newRect( 0, 100, display.contentWidth/2, 400) -- botao esquerdo para movimentar a nave
		left.anchorX = 0
		left.anchorY = 0
		left:setFillColor( 0,0,0,0.1)
		left:setStrokeColor( 1, 0, 0 )
		]]
		left = widget.newButton({width = display.contentWidth/2 + 42, height =400, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0.5, 1 } }, onPress = MoverLeft}  )
		groupScene:insert(left)

	--[[right = display.newRect( display.contentWidth/2, 100, display.contentWidth/2, 400)-- botao direito para movimentar a nave 
		right.anchorX = 0
		right.anchorY = 0
		right:setFillColor( 0,0,0,0.1)
		right:setStrokeColor( 1, 0, 0 )
		]]
		right = widget.newButton({width = display.contentWidth/2 + 42, height =400, x = display.contentWidth/2 + 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0.0, 0.5, 1 } }, onPress = MoverRight}  )
		groupScene:insert(right)

		ButtonFire = widget.newButton({label="Fire",width= 40,height =80, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 180,  shape="circle", fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } }}  )

	--	ButtonFire = display.newCircle(display.contentWidth/2 - 100, display.contentHeight/2 + 180,20 )
		
		quadrado = display.newRect(0, 0, 20, 20) -- primeiro inimigo
		quadrado:setFillColor(1, 0.5, 0.5, 1)
		quadrado.x = 75
		quadrado.y = 350
		quadrado.speed = 1
		physics.setGravity(0,0)
		physics.addBody( quadrado, {friction = 1, bounce = 0} )
		groupScene:insert(quadrado)

		right:addEventListener("touch",MoverRight) -- chama a funcao que faz fazer a nave se movimentar
		left:addEventListener("touch",MoverLeft) -- chama a funcao que faz fazer a nave se movimentar

		estrada1.enterFrame = scrollingRoad 
		Runtime:addEventListener("enterFrame",estrada1) -- vai fazer a estrada rolar 

		estrada2.enterFrame = scrollingRoad 
		Runtime:addEventListener("enterFrame",estrada2) -- vai fazer a segunda estrada rolar

		timer.performWithDelay( 10, Mover ,0 ) -- faz o inimigo se movimentar entre um determinado tempo

		Runtime:addEventListener("collision", onCollision) -- verifica a colisao
end

function MoverRight(event) -- mover a nave para a direita
	
	if event.phase == "began" then
  		image.x = image.x + 10
  	end
  	if event.phase =="ended" then
	   motionX = 0;
	end
end

function MoverLeft(event) -- mover a nave para esquerda
	
	if event.phase == "began" then
  		image.x = image.x - 10
  	end
  	if event.phase =="ended" then
	   motionX = 0;
	end
end

function scrollingRoad(event) -- funcao de movimento da estrada
	if event.y > 725 then
	   event.y = - 250
	else
	    event.y =  event.y + event.speed 
	end
end 

function onCollision(event) -- funcao de colisao
	if event.phase == "began" then
			print("colidiu")
	end
end

function Mover(event)
	
	if flag == 1 then
		movimentoQuadradoDireita()
	elseif flag == 2 then
		movimentoQuadradoBaixo()
	elseif flag == 3 then
		movimentoQuadradoesquerdo()
	elseif flag == 4 then
		movimentoQuadradoBaixo2()
	end
end

function movimentoQuadradoDireita(event)
	if quadrado.x == 250 then
		flag = 2
	else 
		quadrado.x = quadrado.x + 5
	end
end

function movimentoQuadradoBaixo(event)
	quadrado.y = quadrado.y + 15
	flag = 3
end

function movimentoQuadradoesquerdo(event)
	if quadrado.x == 75 then
		flag = 4
	else
		quadrado.x = quadrado.x - 5
	end
end

function movimentoQuadradoBaixo2(event)
	quadrado.y = quadrado.y + 15
	flag = 1
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
