local widget = require( "widget" )
local composer = require ("composer")
local enemy = require ("enemy")
local scene = composer.newScene()
local physics = require("physics")
	  physics.start()

local image
local left
local right
local estrada1
local estrada2
local laser
local ButtonFire

enemy:createEnemy()

function startEnemy() -- cria os inimigos depois do game over
	enemy:createEnemy()
	trm = timer.performWithDelay( 80,chamaMetodoDoEnemy ,0 ) 
end

function startGame() -- inicializa o botao de tiro depois do game over
	
	ButtonFire = widget.newButton({label="Fire",width= 40,height =80, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 180,  shape="circle", fillColor = { default={ 1, 0.2, 0.5, 0.7 }, over={ 0, 0, 0, 0.1} }, onPress = createLaser}  )
end

function scene:create(event)

		local groupScene = self.view
        
        --[[
		linha = display.newLine(0,0,display.contentWidth,0)
		linha:setStrokeColor( 0, 0, 0, 0.1 )
		linha.strokeWidth = 1 
		physics.addBody( linha, "static" ,{friction = 1, bounce = 0} )
		groupScene:insert(linha)
        ]]

		estrada1 = display.newImage("estrada.png")--a primeira estrada
		estrada1.x = display.contentWidth/2
		estrada1.y = 250
		estrada1.speed = 5
		groupScene:insert(estrada1)

		estrada2 = display.newImage("estrada.png")--a segunda estrada a que fica atras da tela
		estrada2.x = display.contentWidth/2
		estrada2.y = - 250
		estrada2.speed = 5
		groupScene:insert(estrada2)

		image = display.newImage("ship.png")--imagem da nave
		image.x = display.contentWidth/2
		image.y = display.contentHeight - 100
		image.speed = 2
		physics.setGravity(0,0)
		physics.addBody( image, "static" ,{friction = 1, bounce = 0} )
		groupScene:insert(image)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		left = widget.newButton({width = display.contentWidth/2 + 42, height =400, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1} }, onPress = MoverLeft}  )
		groupScene:insert(left)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		right = widget.newButton({width = display.contentWidth/2 + 42, height =400, x = display.contentWidth/2 + 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1 } }, onPress = MoverRight}  )
		groupScene:insert(right)
	    --////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		ButtonFire = widget.newButton({label="Fire",width= 40,height =80, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 180,  shape="circle", fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1} }, onPress = createLaser}  )
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		right:addEventListener("touch",MoverRight) -- chama a funcao que faz fazer a nave se movimentar
		left:addEventListener("touch",MoverLeft) -- chama a funcao que faz fazer a nave se movimentar
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		timer.performWithDelay( 80,scrollingRoadEstrada2 ,0 )
		timer.performWithDelay( 80,scrollingRoadEstrada1 ,0 )
		trm = timer.performWithDelay( 80,chamaMetodoDoEnemy ,0 ) -- faz o inimigo se movimentar entre um determinado tempo
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		Runtime:addEventListener("collision", onCollision) -- verifica a colisao	
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
	if estrada1.y > 725 then
	   estrada1.y = - 250
	else
	    estrada1.y =  estrada1.y + estrada1.speed 
	end
end 

 function scrollingRoadEstrada2(event) -- funcao de movimento da estrada
	if estrada2.y > 725 then
	   estrada2.y = - 250
	else
	    estrada2.y =  estrada2.y + estrada2.speed 
	end
end 

 function onCollision(event) -- funcao de colisao
	  
	if event.phase == "began" then	


		print(inimigo2.x)
		print(laser.y)
		print(event.target)
	--	inimigo2:removeSelf()

	--enemy:scrollEnemy2()
		--print(event.target.x)
		--print(self.other)
	--	print(event.other.x)

		--timer.cancel(trm)
		--display.remove(ButtonFire)
		--enemy:destroy()
		--composer.gotoScene("gameover")
	
	
	end
end

 function createLaser(event) -- cria o laser
	ButtonFire:setEnabled( false )
	group = display.newGroup()
	laser = display.newImage("Lazer.png")
	physics.addBody( laser, "dinamic", {isSensor = true})
	laser.isBullet = true --  para se o corpo deve ser tratado como uma "bala". As balas estão sujeitas a detecção contínua de colisão em vez de detecção periódica de colisão em etapas de tempo
	laser.x = image.x
	laser.y = image.y - 50
	laser.collType = "laser"
	
	--laser:addEventListener("tap",function_name)
	--grupos[#grupos+1] = laser
	group:insert( laser )

	 tm = timer.performWithDelay(10,moverLaser,0)
	
--	transition.to(laser,{time=500,y = 20, transition = easing.linear, onComplete = display.remove(laser)})
--  transition.to( laser, {y= 20, time = 500, onComplete = function() display.remove( laser )end} )
end
function moverLaser()

	for i=1,group.numChildren do

   		if group[i].y <= 20 then
   			--print("menor")
   			display.remove( laser )
   			timer.cancel(tm)
   			ButtonFire:setEnabled( true )
   		else 
			laser:translate( 0, -25 )
		end
    --local child = group[i]
    --local description = (child.isVisible and "visible") or "not visible"
    --print( "child["..i.."] is " .. description )
	end
end

--[[
function function_name(event)
	-- transition.to( laser, {y=10, time = 500, onComplete = function() display.remove( laser )end} )
	-- transition.to( event.target, {y=10, time = 500, onComplete = function() display.remove( event.target )end} )
	-- return true
end]]
--[[
function moverLaser()

	if laser.y <= 110 then
		display.remove( laser )
		timer.cancel(tm)
	else
		
	laser:translate( 0, -10 )
	end
end
]]
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
