local widget = require( "widget" )
local composer = require ("composer")
local enemy = require ("enemy")
local scene = composer.newScene()
local physics = require("physics")
	  physics.start()
	  --physics.setDrawMode('hybrid')

local imageShip
local left
local right
local estrada1
local estrada2
local laser
local ButtonFire
local ButtonFireValidacao = true
local wall1
local wall2
local timerDaChamadaDoMetodoDoInimigo = 60
pontuacao = ""

function scene:create(event)

		enemy:createEnemy()

		local groupScene = self.view

		pontuacao = display.newText( "0", display.contentWidth/2 + 140, 10 )
		pontuacao:setFillColor( 1, 0, 0 )
		groupScene:insert(pontuacao)
	
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

		imageShip = display.newImage("ship.png")--imageShipm da nave
		imageShip.x = display.contentWidth/2
		imageShip.y = display.contentHeight - 100
		imageShip.speed = 2
		imageShip.name = "ship"
		physics.setGravity(0,0)
		physics.addBody( imageShip, "static" ,{friction = 1, bounce = 0} )
		groupScene:insert(imageShip)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		left = widget.newButton({width = display.contentWidth/2 + 42, height =650, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1} }, onPress = MoverLeft}  )
		groupScene:insert(left)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		right = widget.newButton({width = display.contentWidth/2 + 42, height =650, x = display.contentWidth/2 + 100, y = display.contentHeight/2 + 40 ,  shape="roundedRect",fillColor = { default={ 0, 0, 0, 0.1 }, over={ 0, 0, 0, 0.1 } }, onPress = MoverRight}  )
		groupScene:insert(right)
	    --////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		ButtonFire = widget.newButton({label="Fire",width= 20,height =40, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 235,  shape="circle", fillColor = { default={ 1, 0, 1, 1 }, over={ 0, 1, 1, 1} }, onPress = createLaser}  )
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		right:addEventListener("touch",MoverRight) -- chama a funcao que faz fazer a nave se movimentar
		left:addEventListener("touch",MoverLeft) -- chama a funcao que faz fazer a nave se movimentar
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		timer.performWithDelay( 80,scrollingRoadEstrada2 ,0 )
		timer.performWithDelay( 80,scrollingRoadEstrada1 ,0 )
		timerDeChamadaDoMetodoDeInimigo = timer.performWithDelay( 60,chamaMetodoDoEnemy ,0 ) -- faz o inimigo se movimentar entre um determinado tempo
		timerDeChamadaDoMetodoDeMudarPontuacao = timer.performWithDelay(2000, mudarPontuacao,0)
		--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		imageShip:addEventListener("collision", onCollision) -- verifica a colisao	
end

function startEnemy() -- cria os inimigos depois do game over
	enemy:createEnemy()
	timerDeChamadaDoMetodoDeInimigo = timer.performWithDelay( 80,chamaMetodoDoEnemy ,0 ) 
end

function startGame() -- inicializa o botao de tiro depois do game over	

	ButtonFire = widget.newButton({label="Fire",width= 20,height =40, x = display.contentWidth/2 - 100, y = display.contentHeight/2 + 200,  shape="circle", fillColor = { default={ 1, 0, 1, 1 }, over={ 0, 1, 1, 1} }, onPress = createLaser}  )

	imageShip.x = display.contentWidth/2
	imageShip.y = display.contentHeight - 100

	pontuacao.text = "0"

end

function mudarPontuacao() -- muda a pontuacao depois de um tempo pre-definido
	
	pontuacao.text = pontuacao.text + 10

	local numero = tonumber(pontuacao.text) -- converte uma string para numero	

	if numero >= 100 and numero < 200 then --altera a velocidade do inimigo de acordo com a pontuacao
		print(pontuacao.text)
		print("entrou 1")
		enemy:mudarSpeed(1)
	elseif numero >= 200 and numero < 300 then
		print("entrou 2")
		print(pontuacao.text)
		enemy:mudarSpeed(2)
		--timerDaChamadaDoMetodoDoInimigo = 40
	elseif numero >= 300 and numero < 400 then
		print("entrou 3")
		print(pontuacao.text)
		enemy:mudarSpeed(3)
		--timerDaChamadaDoMetodoDoInimigo = 30
	elseif numero >= 400 and numero < 500 then
		enemy:mudarSpeed(4)
	elseif numero >= 500 then
		enemy:mudarSpeed(5)
	end
end

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function MoverRight(event) -- mover a nave para a direita
	
	if event.phase == "began" then
		if imageShip.x > 230 then
			naveSaiuDaAreaPermitida()
		else
  		imageShip.x = imageShip.x + 10
  		end
  	end
  	if event.phase =="ended" then
	   motionX = 0;
	end
end

function MoverLeft(event) -- mover a nave para esquerda
	
	if event.phase == "began" then
		if imageShip.x < 90 then
			naveSaiuDaAreaPermitida()
		else
  		imageShip.x = imageShip.x - 10
  		end
  	end
  	if event.phase =="ended" then
	   motionX = 0;
	end
end

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function naveSaiuDaAreaPermitida()
	timer.cancel(timerDeChamadaDoMetodoDeInimigo)
			display.remove(ButtonFire)
			enemy:destroy()
			composer.gotoScene("gameover")
end

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function recriarInimigo1()
	inimigo1.validacao = false
	enemy:changePositionY1()
	timer.resume(timerDeChamadaDoMetodoDeInimigo)
	physics.start()
	ButtonFireValidacao = true
	--timer.resume(timerDeChamadaDoMetodoDeMudarPontuacao)
end

function recriarInimigo2()
	--print("opa")
	inimigo2.validacao = false	
	enemy:changePositionY2()
	timer.resume(timerDeChamadaDoMetodoDeInimigo)
	physics.start()
	ButtonFireValidacao = true
	--timer.resume(timerDeChamadaDoMetodoDeMudarPontuacao)
end

function recriarInimigo3()
	--print("opa")
	inimigo3.validacao = false	
	enemy:changePositionY3()
	timer.resume(timerDeChamadaDoMetodoDeInimigo)
	physics.start()
	ButtonFireValidacao = true
	--timer.resume(timerDeChamadaDoMetodoDeMudarPontuacao)
end

function recriarInimigo4()
	--print("opa")
	inimigo4.validacao = false	
	enemy:changePositionY4()
	timer.resume(timerDeChamadaDoMetodoDeInimigo)
	physics.start()
	ButtonFireValidacao = true
	--timer.resume(timerDeChamadaDoMetodoDeMudarPontuacao)
end

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function onCollision(event) -- funcao de colisao
	--timer.pause(timerDeChamadaDoMetodoDeMudarPontuacao)
	
	if event.phase == "began" then	

		
		if event.target.name == "ship" then

			timer.cancel(timerDeChamadaDoMetodoDeInimigo)
			display.remove(ButtonFire)
			enemy:destroy()
			composer.gotoScene("gameover")
	
		elseif event.target.name == "laser" then
			
			if event.other.name == "inimigo1" then
				timer.pause(timerDeChamadaDoMetodoDeInimigo)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				timerDeChamadaDoMetodoDeInimigo1 = timer.performWithDelay(40, recriarInimigo1)
			end
			if event.other.name == "inimigo2" then
				timer.pause(timerDeChamadaDoMetodoDeInimigo)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				timerDeChamadaDoMetodoDeInimigo2 = timer.performWithDelay( 40, recriarInimigo2 )
			end
			if event.other.name == "inimigo3" then
				timer.pause(timerDeChamadaDoMetodoDeInimigo)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				timerDeChamadaDoMetodoDeInimigo2 = timer.performWithDelay( 40, recriarInimigo3 )
				
			end
			if event.other.name == "inimigo4" then
				timer.pause(timerDeChamadaDoMetodoDeInimigo)
				display.remove(event.target)
				display.remove(event.other)
				physics.pause()
				timerDeChamadaDoMetodoDeInimigo2 = timer.performWithDelay( 40, recriarInimigo4 )
				
			end
		end
	end
end

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function createLaser(event) -- cria o laser

	if ButtonFireValidacao == true then
		--print("criou")
		ButtonFireValidacao = false
		laser = display.newImage("Lazer.png")
		physics.addBody( laser, "kinematic")
		laser.x = imageShip.x
		laser.y = imageShip.y - 50
		laser.collType = "laser"
		laser.name = "laser"
		laser:setLinearVelocity(0, -300)
		laser:addEventListener("collision", onCollision)
		tm = timer.performWithDelay(10,moverLaser,0)
	end
end

function moverLaser()

	if laser.y ~= nil then
   		if laser.y <= -45 then
   			
   			display.remove( laser )
   			ButtonFireValidacao = true
   			
   		end
   	end
end

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
