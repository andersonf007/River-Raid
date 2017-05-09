local composer = require ("composer")
local physics = require("physics")
	  physics.start()
local enemy = {}
local quadrado
local flag = 1

function enemy:createEnemy()
	
	quadrado = display.newRect(0, 0, 20, 20) -- primeiro inimigo
	quadrado:setFillColor(1, 0.5, 0.5, 1)
	quadrado.x = 75
	quadrado.y = 10
	quadrado.speed = 1
	physics.setGravity(0,0)
	physics.addBody( quadrado, {friction = 1, bounce = 0} )

end

function enemy:Mover()
--print("1")
	if flag == 1 then

		self:movimentoQuadradoDireita()
	elseif flag == 2 then
		 self:movimentoQuadradoBaixo()
	elseif flag == 3 then
		 self:movimentoQuadradoesquerdo()
	elseif flag == 4 then
		 self:movimentoQuadradoBaixo2()
	end
end

function enemy:movimentoQuadradoDireita()
	print(quadrado.x)
	if quadrado.x >= 250 then
		flag = 2
	else 
		quadrado.x = quadrado.x + 5
	end
end

function enemy:movimentoQuadradoBaixo()
	quadrado.y = quadrado.y + 15
	flag = 3
end

function enemy:movimentoQuadradoesquerdo()
	if quadrado.x <= 75 then
		flag = 4
	else
		quadrado.x = quadrado.x - 5
	end
end

function enemy:movimentoQuadradoBaixo2()
	quadrado.y = quadrado.y + 15
	flag = 1
end


return enemy
