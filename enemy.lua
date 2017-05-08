local composer = require ("composer")
local scene = {}
local quadrado
local flag = 1

function scene:createEnemy()
	
--	local groupScene = self.view
	
	quadrado = display.newRect(0, 0, 20, 20) -- primeiro inimigo
	quadrado:setFillColor(1, 0.5, 0.5, 1)
	quadrado.x = 75
	quadrado.y = 10
	quadrado.speed = 1
--	groupScene:insert(quadrado)
end

function scene:Mover()
print("1")
	if flag == 1 then

		self:movimentoQuadradoDireita()
	elseif flag == 2 then
		 scene:movimentoQuadradoBaixo()
	elseif flag == 3 then
		 scene:movimentoQuadradoesquerdo()
	elseif flag == 4 then
		 scene:movimentoQuadradoBaixo2()
	end
end

function scene:movimentoQuadradoDireita()
	if quadrado.x == 250 then
		flag = 2
	else 
		quadrado.x = quadrado.x + 5
	end
end

function scene:movimentoQuadradoBaixo()
	quadrado.y = quadrado.y + 15
	flag = 3
end

function scene:movimentoQuadradoesquerdo()
	if quadrado.x == 75 then
		flag = 4
	else
		quadrado.x = quadrado.x - 5
	end
end

function scene:movimentoQuadradoBaixo2()
	quadrado.y = quadrado.y + 15
	flag = 1
end


return scene
