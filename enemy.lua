local composer = require ("composer")
local physics = require("physics")
local enemy = {}

local chamadaDaFuncaoDoMovimentoDoInimigo = 1
local chamadaDaFuncaoDoMovimentoDoInimigo2 = 1
local chamadaDaFuncaoDoMovimentoDoInimigo3 = 1
local chamadaDaFuncaoDoMovimentoDoInimigo4 = 1


function criarInimigo(x,y,nome)

	local inimigo = display.newRect(0, 0, 20, 20) -- primeiro inimigo
	inimigo:setFillColor(1, 0.5, 0.5, 1)
	inimigo.x = x
	inimigo.y = y
	inimigo.speed = 1
	inimigo.name = nome
	inimigo.validacao = true
	physics.setGravity(0,0)
	physics.addBody( inimigo, "dynamic", {friction = 0, bounce = -1, density=2} )	
	inimigo.isFixedRotation = true
	inimigo:addEventListener("collision", onCollision) 
	return inimigo
end

function enemy:createEnemy() -- criar inimigo
	
	inimigo1 = criarInimigo(70,20,"inimigo1")
	inimigo2 = criarInimigo(70,250,"inimigo2")
	inimigo3 = criarInimigo(240,130,"inimigo3")
	inimigo4 = criarInimigo(240,-180,"inimigo4")
end

-------//ENEMY1/////////////////////////////////////////////////////////////////////////////------
function enemy:MoverEnemy() -- chama as funcoes de movimento dos inimigos
	--print("1")
	if chamadaDaFuncaoDoMovimentoDoInimigo == 1 then
		self:moverEnemyRight()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo == 2 then
		 self:moverEnemyDown()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo == 3 then
		 self:moverEnemyLeft()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo == 4 then
		 self:moverEnemyDown2()
	end
end

function enemy:moverEnemyRight()
	--print(inimigo.x)
	if inimigo1.validacao == true then

		if inimigo1.x >= 125 then
			chamadaDaFuncaoDoMovimentoDoInimigo = 2
		else 
			inimigo1.x = inimigo1.x + 5
		end
	end
end

function enemy:moverEnemyDown()

	if inimigo1.validacao == true then

		inimigo1.y = inimigo1.y + 15
		chamadaDaFuncaoDoMovimentoDoInimigo = 3
		
	end
end

function enemy:moverEnemyLeft()

	if inimigo1.validacao == true then
		if inimigo1.x <= 70 then
			chamadaDaFuncaoDoMovimentoDoInimigo = 4
		else
			inimigo1.x = inimigo1.x - 5
		end
	end
end

function enemy:moverEnemyDown2()

	if inimigo1.validacao == true then

		inimigo1.y = inimigo1.y + 15

		chamadaDaFuncaoDoMovimentoDoInimigo = 1
	end
end

-------//ENEMY2/////////////////////////////////////////////////////////////////////////////------
function enemy:MoverEnemy2()

	if chamadaDaFuncaoDoMovimentoDoInimigo2 == 1 then
		self:moverEnemy2Right()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo2 == 2 then
		 self:moverEnemy2Down()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo2 == 3 then
		 self:moverEnemy2Left()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo2 == 4 then
		 self:moverEnemy2Down2()
	end

end

function enemy:moverEnemy2Right()

	if inimigo2.validacao == true then
		--print(inimigo.x)
		if inimigo2.x >= 125 then
			chamadaDaFuncaoDoMovimentoDoInimigo2 = 2
		else 
			inimigo2.x = inimigo2.x + 5
		end
	end
end

function enemy:moverEnemy2Down()

	if inimigo2.validacao == true then

		inimigo2.y = inimigo2.y + 15
		chamadaDaFuncaoDoMovimentoDoInimigo2 = 3
	end
end

function enemy:moverEnemy2Left()

	if inimigo2.validacao == true then

		if inimigo2.x <= 70 then
			chamadaDaFuncaoDoMovimentoDoInimigo2 = 4
		else
			inimigo2.x = inimigo2.x - 5
		end
	end
end

function enemy:moverEnemy2Down2()

	if inimigo2.validacao == true then
		inimigo2.y = inimigo2.y + 15
		chamadaDaFuncaoDoMovimentoDoInimigo2 = 1
	end
end
-------//ENEMY3////////////////////////////////////////////////////////////////////////////-------

function enemy:MoverEnemy3()

	if chamadaDaFuncaoDoMovimentoDoInimigo3 == 1 then
		 self:moverEnemy3Left()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo3 == 2 then
		 self:moverEnemy3Down()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo3 == 3 then
		self:moverEnemy3Right()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo3 == 4 then
		 self:moverEnemy3Down2()
	end	
end

function enemy:moverEnemy3Left()

	if inimigo3.validacao == true then
		if inimigo3.x <= 195 then
			chamadaDaFuncaoDoMovimentoDoInimigo3 = 2
		else
			inimigo3.x = inimigo3.x - 5
		end
	end
end

function enemy:moverEnemy3Down()

	if inimigo3.validacao == true then
		inimigo3.y = inimigo3.y + 15
		chamadaDaFuncaoDoMovimentoDoInimigo3 = 3
	end
end

function enemy:moverEnemy3Right()

	if inimigo3.validacao == true then
		if inimigo3.x >= 250 then
			chamadaDaFuncaoDoMovimentoDoInimigo3 = 4
		else
			inimigo3.x = inimigo3.x + 5
		end
	end
end

function enemy:moverEnemy3Down2()

	if inimigo3.validacao == true then
		inimigo3.y = inimigo3.y + 15
		chamadaDaFuncaoDoMovimentoDoInimigo3 = 1
	end
end

-------//ENEMY4////////////////////////////////////////////////////////////////////////////-------

function enemy:MoverEnemy4()
	if chamadaDaFuncaoDoMovimentoDoInimigo4 == 1 then
		 self:moverEnemy4Left()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo4 == 2 then
		 self:moverEnemy4Down()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo4 == 3 then
		self:moverEnemy4Right()
	elseif chamadaDaFuncaoDoMovimentoDoInimigo4 == 4 then
		 self:moverEnemy4Down2()
	end	
end

function enemy:moverEnemy4Left()

	if inimigo4.validacao == true then
		if inimigo4.x <= 195 then
			chamadaDaFuncaoDoMovimentoDoInimigo4 = 2
		else
			inimigo4.x = inimigo4.x - 5
		end
	end
end

function enemy:moverEnemy4Down()

	if inimigo4.validacao == true then
		inimigo4.y = inimigo4.y + 15
		chamadaDaFuncaoDoMovimentoDoInimigo4 = 3
	end
end

function enemy:moverEnemy4Right()

	if inimigo4.validacao == true then
		if inimigo4.x >= 250 then
			chamadaDaFuncaoDoMovimentoDoInimigo4 = 4
		else
			inimigo4.x = inimigo4.x + 5
		end
	end
end

function enemy:moverEnemy4Down2()

	if inimigo4.validacao == true then
		inimigo4.y = inimigo4.y + 15
		chamadaDaFuncaoDoMovimentoDoInimigo4 = 1
	end
end

---------------------------------------------------------------------------------------------------

function enemy:scrollEnemy1() -- movimenta de restauracao do inimigo 1 depois que ele sai da tela
	if inimigo1.validacao == true then
		if inimigo1.y >= 470 then
			inimigo1.y = 0
		end
	end
end

function enemy:scrollEnemy2()  -- movimenta de restauracao do inimigo 2 depois que ele sai da tela
	if inimigo2.validacao == true then
		if inimigo2.y >= 470 then
			inimigo2.y = 0
		end
	end
end

function enemy:scrollEnemy3()  -- movimenta de restauracao do inimigo 3 depois que ele sai da tela
	if inimigo3.validacao == true then
		if inimigo3.y >= 470 then
			inimigo3.y = 0
		end
	end
end

function enemy:scrollEnemy4()  -- movimenta de restauracao do inimigo 4 depois que ele sai da tela
	if inimigo4.validacao == true then
		if inimigo4.y >= 470 then
			inimigo4.y = 0
		end
	end
end

----------------------------------------------------------------------------------------------------

function enemy:changePositionY1()

	if inimigo1.validacao == false then
		display.remove(inimigo1)
		inimigo1 = criarInimigo(70,-50,"inimigo1")
		inimigo1.validacao = true
		chamadaDaFuncaoDoMovimentoDoInimigo = 1
	end
end

function enemy:changePositionY2()
	
	if inimigo2.validacao == false then
		display.remove(inimigo2)
		inimigo2 = criarInimigo(70,-50, "inimigo2")
		inimigo2.validacao = true
		chamadaDaFuncaoDoMovimentoDoInimigo2 = 1
	end
end

function enemy:changePositionY3()
	
	if inimigo3.validacao == false then
		display.remove(inimigo3)
		inimigo3 = criarInimigo(240,-50,"inimigo3")
		inimigo3.validacao = true
		chamadaDaFuncaoDoMovimentoDoInimigo3 = 1
	end
end

function enemy:changePositionY4()
	
	if inimigo4.validacao == false then
		display.remove(inimigo4)
		inimigo4 = criarInimigo(240,-50,"inimigo4")
		inimigo4.validacao = true
		chamadaDaFuncaoDoMovimentoDoInimigo4 = 1
	end
end

function enemy:destroy() -- remove todos os inimigos depois da colisao

	inimigo1:removeSelf()
	inimigo2:removeSelf()
	inimigo3:removeSelf()
	inimigo4:removeSelf() 
end

return enemy