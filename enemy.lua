local composer = require ("composer")
local physics = require("physics")
	  physics.start()
local enemy = {}
local inimigo
local inimigo2
local inimigo3
local inimigo4
local flag = 1
local flag2 = 1
local flag3 = 1
local flag4 = 1

function enemy:createEnemy() -- criar inimigo
	
	inimigo = display.newRect(0, 0, 20, 20) -- primeiro inimigo
	inimigo:setFillColor(1, 0.5, 0.5, 1)
	inimigo.x = 70
	inimigo.y = 10
	inimigo.speed = 1
	physics.setGravity(0,0)
	physics.addBody( inimigo, {friction = 1, bounce = 0} )

	inimigo2 =  display.newRect(0, 0, 20, 20) -- segundo inimigo
	inimigo2:setFillColor(1, 0.9, 0.5, 1)
	inimigo2.x = 70
	inimigo2.y = 250
	inimigo2.speed = 1
	physics.setGravity(0,0)
	physics.addBody( inimigo2, {friction = 1, bounce = 0} )

	inimigo3 = display.newRect(0, 0, 20, 20) -- terceiro inimigo
	inimigo3:setFillColor(1, 0.5, 0.9, 1)
	inimigo3.x = 240
	inimigo3.y = 130
	inimigo3.speed = 1
	physics.setGravity(0,0)
	physics.addBody( inimigo3, {friction = 1, bounce = 0} )

	inimigo4 = display.newRect(0, 0, 20, 20) -- terceiro inimigo
	inimigo4:setFillColor(1, 0.5, 0.9, 0.6)
	inimigo4.x = 240
	inimigo4.y = - 120
	inimigo4.speed = 1
	physics.setGravity(0,0)
	physics.addBody( inimigo4, {friction = 1, bounce = 0} )
end

-------//ENEMY1/////////////////////////////////////////////////////////////////////////////------
function enemy:MoverEnemy()
	--print("1")
	if flag == 1 then
		self:moverEnemyRight()
	elseif flag == 2 then
		 self:moverEnemyDown()
	elseif flag == 3 then
		 self:moverEnemyLeft()
	elseif flag == 4 then
		 self:moverEnemyDown2()
	end
end

function enemy:moverEnemyRight()
	--print(inimigo.x)
	if inimigo.x >= 125 then
		flag = 2
	else 
		inimigo.x = inimigo.x + 5
	end
end

function enemy:moverEnemyDown()
	inimigo.y = inimigo.y + 15
	flag = 3
end

function enemy:moverEnemyLeft()
	if inimigo.x <= 70 then
		flag = 4
	else
		inimigo.x = inimigo.x - 5
	end
end

function enemy:moverEnemyDown2()
	inimigo.y = inimigo.y + 15

	flag = 1
end

-------//ENEMY2/////////////////////////////////////////////////////////////////////////////------
function enemy:MoverEnemy2()
	
	if flag2 == 1 then
		self:moverEnemy2Right()
	elseif flag2 == 2 then
		 self:moverEnemy2Down()
	elseif flag2 == 3 then
		 self:moverEnemy2Left()
	elseif flag2 == 4 then
		 self:moverEnemy2Down2()
	end
end

function enemy:moverEnemy2Right()
	--print(inimigo.x)
	if inimigo2.x >= 125 then
		flag2 = 2
	else 
		inimigo2.x = inimigo2.x + 5
	end
end

function enemy:moverEnemy2Down()
	inimigo2.y = inimigo2.y + 15
	flag2 = 3
end

function enemy:moverEnemy2Left()
	if inimigo2.x <= 70 then
		flag2 = 4
	else
		inimigo2.x = inimigo2.x - 5
	end
end

function enemy:moverEnemy2Down2()
	inimigo2.y = inimigo2.y + 15
	flag2 = 1
end
-------//ENEMY3////////////////////////////////////////////////////////////////////////////-------

function enemy:MoverEnemy3()

	if flag3 == 1 then
		 self:moverEnemy3Left()
	elseif flag3 == 2 then
		 self:moverEnemy3Down()
	elseif flag3 == 3 then
		self:moverEnemy3Right()
	elseif flag3 == 4 then
		 self:moverEnemy3Down2()
	end	
end

function enemy:moverEnemy3Left()

	if inimigo3.x <= 195 then
		flag3 = 2
	else
		inimigo3.x = inimigo3.x - 5
	end
end

function enemy:moverEnemy3Down()
	inimigo3.y = inimigo3.y + 15
	flag3 = 3
end

function enemy:moverEnemy3Right()
	if inimigo3.x >= 250 then
		flag3 = 4
	else
		inimigo3.x = inimigo3.x + 5
	end
end

function enemy:moverEnemy3Down2()
	inimigo3.y = inimigo3.y + 15
	flag3 = 1
end

-------//ENEMY4////////////////////////////////////////////////////////////////////////////-------

function enemy:MoverEnemy4()
	if flag4 == 1 then
		 self:moverEnemy4Left()
	elseif flag4 == 2 then
		 self:moverEnemy4Down()
	elseif flag4 == 3 then
		self:moverEnemy4Right()
	elseif flag4 == 4 then
		 self:moverEnemy4Down2()
	end	
end

function enemy:moverEnemy4Left()

	if inimigo4.x <= 195 then
		flag4 = 2
	else
		inimigo4.x = inimigo4.x - 5
	end
end

function enemy:moverEnemy4Down()
	inimigo4.y = inimigo4.y + 15
	flag4 = 3
end

function enemy:moverEnemy4Right()
	if inimigo4.x >= 250 then
		flag4 = 4
	else
		inimigo4.x = inimigo4.x + 5
	end
end

function enemy:moverEnemy4Down2()
	inimigo4.y = inimigo4.y + 15
	flag4 = 1
end

---------------------------------------------------------------------------------------------------

function enemy:scrollEnemy1() -- movimenta o inimigo 1
	if inimigo.y >= 470 then
		inimigo.y = 0
	end
end

function enemy:scrollEnemy2()  -- movimenta o inimigo 2
	if inimigo2.y >= 470 then
		inimigo2.y = 0
	end
end

function enemy:scrollEnemy3()  -- movimenta o inimigo 3
	if inimigo3.y >= 470 then
		inimigo3.y = 0
	end
end

function enemy:scrollEnemy4()  -- movimenta o inimigo 4
	if inimigo4.y >= 470 then
		inimigo4.y = 0
	end
end

function enemy:destroy() -- remove todos os inimigos 

	inimigo:removeSelf()
	inimigo2:removeSelf()
	inimigo3:removeSelf()
	inimigo4:removeSelf() 
end



return enemy