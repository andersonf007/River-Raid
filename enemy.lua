local composer = require ("composer")
local scene = composer.newScene()
local quadrado
local flag = 1

function scene:create(event)
	
	local groupScene = self.view
	
	quadrado = display.newRect(0, 0, 20, 20) -- primeiro inimigo
	quadrado:setFillColor(1, 0.5, 0.5, 1)
	quadrado.x = 75
	quadrado.y = 10
	quadrado.speed = 1
	groupScene:insert(quadrado)

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
