local widget = require( "widget" )
local composer = require ("composer")
local enemy = require ("enemy")
local scene = composer.newScene()
local physics = require("physics")
	  physics.start()
	 physics.setDrawMode('hybrid')

local image
local left
local right
local estrada1
local estrada2
local laser
local ButtonFire
local ButtonFireValidacao = true

function startEnemy() -- cria os inimigos depois do game over
	enemy:createEnemy()
	trm = timer.performWithDelay( 80,chamaMetodoDoEnemy ,0 ) 
end

function startGame() -- inicializa o botao de tiro depois do game over	

	ButtonFire = widget.newButton({label="Fire",width= 20,height =40, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 200,  shape="circle", fillColor = { default={ 1, 0, 1, 1 }, over={ 0, 1, 1, 1} }, onPress = createLaser}  )
end

function scene:create(event)

		enemy:createEnemy()

		local groupScene = self.view
     
		estrada1 = display.newImage("estrada.png")--a primeira estrada
		estrada1.x = display.contentWidth/2
		estrada1.y = 250
		estrada1.speed = 5
		groupScene:insert(estrada1)

		estrada2 = display.newImage("estrada.png")--a segunda estrada a que fica atras da tela
		estrada2.x = display.contentWidth/2
		estrada2.y = - 409
		estrada2.speed = 5
		groupScene:insert(estrada2)

		image = display.newImage("ship.png")--imagem da nave
		image.x = display.contentWidth/2
		image.y = display.contentHeight - 100
		image.speed = 2
		image.name = "ship"
		physics.setGravity(0,0)
		physics.addBody( image, "static" ,{friction = 1, bounce = 0} )
		groupScene:insert(image)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		left = widget.newButton({width = display.contentWidth/2 + 42, height =650, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1} }, onPress = MoverLeft}  )
		groupScene:insert(left)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		right = widget.newButton({width = display.contentWidth/2 + 42, height =650, x = display.contentWidth/2 + 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1 } }, onPress = MoverRight}  )
		groupScene:insert(right)
	    --////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		ButtonFire = widget.newButton({label="Fire",width= 20,height =40, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 200,  shape="circle", fillColor = { default={ 1, 0, 1, 1 }, over={ 0, 1, 1, 1} }, onPress = createLaser}  )
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		right:addEventListener("touch",MoverRight) -- chama a funcao que faz fazer a nave se movimentar
		left:addEventListener("touch",MoverLeft) -- chama a funcao que faz fazer a nave se movimentar
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		timer.performWithDelay( 80,scrollingRoadEstrada2 ,0 )
		timer.performWithDelay( 80,scrollingRoadEstrada1 ,0 )
		trm = timer.performWithDelay( 80,chamaMetodoDoEnemy ,0 ) -- faz o inimigo se movimentar entre um determinado tempo
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		image:addEventListener("collision", onCollision) -- verifica a colisao			
end

function chamaMetodoDoEnemy()-- chama os metodos dos inimigos

	enemy:MoverEnemy()
	enemy:MoverEnemy2()
	enemy:MoverEnemy3()
	enemy:MoverEnemy4()	
	enemy:scrollEnemy1()
	enemy:scrollEnemy2()
	enemy:scrollEnemy3()
	enemy:scrollEnemy4()
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

function scrollingRoadEstrada1(event) -- funcao de movimento da estrada
	if estrada1.y > 896 then
	   estrada1.y = - 400
	else
	    estrada1.y =  estrada1.y + estrada1.speed 
	end
end 

function scrollingRoadEstrada2(event) -- funcao de movimento da estrada
	if estrada2.y > 896 then
	   estrada2.y = - 400
	else
	    estrada2.y =  estrada2.y + estrada2.speed 
	end
end 

function recriarInimigo1()
	inimigo1.validacao = false
	enemy:changePositionY1()
	timer.resume(trm)
	physics.start()
	ButtonFireValidacao = true
end

function recriarInimigo2()
	--print("opa")
	inimigo2.validacao = false	
	enemy:changePositionY2()
	timer.resume(trm)
	physics.start()
	ButtonFireValidacao = true
end

function recriarInimigo3()
	--print("opa")
	inimigo3.validacao = false	
	enemy:changePositionY3()
	timer.resume(trm)
	physics.start()
	ButtonFireValidacao = true
end

function recriarInimigo4()
	--print("opa")
	inimigo4.validacao = false	
	enemy:changePositionY4()
	timer.resume(trm)
	physics.start()
	ButtonFireValidacao = true
end

function onCollision(event) -- funcao de colisao

	--print("colidiu")
	if event.phase == "began" then	

		if event.target.name == "ship" then

			timer.cancel(trm)
			display.remove(ButtonFire)
			enemy:destroy()
			composer.gotoScene("gameover")
	
		elseif event.target.name == "laser" then
			
			if event.other.name == "inimigo1" then
				timer.pause(trm)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				trm1 = timer.performWithDelay(40, recriarInimigo1)
			end
			if event.other.name == "inimigo2" then
				timer.pause(trm)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				trm2 = timer.performWithDelay( 40, recriarInimigo2 )
			end
			if event.other.name == "inimigo3" then
				timer.pause(trm)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				trm2 = timer.performWithDelay( 40, recriarInimigo3 )
				
			end
			if event.other.name == "inimigo4" then
				timer.pause(trm)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				trm2 = timer.performWithDelay( 40, recriarInimigo4 )
				
			end
		end
	end
end

function createLaser(event) -- cria o laser

	if ButtonFireValidacao == true then
		--print("criou")
		ButtonFireValidacao = false
		laser = display.newImage("Lazer.png")
		physics.addBody( laser, "kinematic")
		laser.x = image.x
		laser.y = image.y - 50
		laser.collType = "laser"
		laser.name = "laser"
		laser:setLinearVelocity(0, -300)
		laser:addEventListener("collision", onCollision)
		tm = timer.performWithDelay(10,moverLaser,0)
	end

end

function moverLaser()

	if laser.y ~= nil then
   		if laser.y <= -25 then
   			
   			display.remove( laser )
   			ButtonFireValidacao = true
   			
   		end
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
