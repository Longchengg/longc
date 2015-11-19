--
-- Author: zyuq
-- Date: 2015-11-16 09:51:19
--
local Hero = class("Hero", function()
	return display.newNode()
end)

walk = true

function Hero:ctor()
	self.player = Player:new()
	self.player:addTo(self)
	self.player:setPosition(cc.p(0, 0))
	self:init()
end

function Hero:init()	
	-- 开启定时器
	self:schedule()
end

function Hero:setHeroDirection(Direction,FaceDirection)
	self.rockerDirection = Direction
	self.faceDirection = FaceDirection
end

function Hero:newRect(v)
	local size = v:getContentSize()
    local x = v:getPositionX()
    local y = v:getPositionY()
    local rect = cc.rect(x-size.width/2, y-size.height/2, size.width, size.height)
    return rect
end

function Hero:getHero()
    return self.player
    
end

-- 定时器
function Hero:schedule()
	local scheduler = cc.Director:getInstance():getScheduler()
	self.id = scheduler:scheduleScriptFunc(handler(self, Hero.scheduleFun), 1/60, false)
end

function Hero:scheduleFun()
	local x = self:getPositionX()
	local y = self:getPositionY()
	local speed = 5 -- 设置移动速度
	local minX = 200
	local minY = 0
	local maxX = display.width * 2 - minX
	local maxY = 280 + minY 	--战斗层的宽度
	if self.rockerDirection == 0 and walk == true then
		walk = false
		if self.player.fsm:canDoEvent("stopAction") then
		   self.player.fsm:doEvent("stopAction")
		end
	elseif self.rockerDirection == 1 then 	-- 向右走
		if x + speed > maxX then
			self:setPosition(cc.p(maxX, y))
		else
			self:setPosition(cc.p(x + speed, y))
		end
	elseif self.rockerDirection == 2 then 	-- 向右上走
		if x >= maxX and y >= maxY then
			self:setPosition(cc.p(maxX, maxY))
		end
		if x >= maxX and y <maxY then
			self:setPosition(cc.p(x, y + speed))
		end
		if x < maxX and y >= maxY then
			self:setPosition(cc.p(x + speed, maxY))
		end
		if x < maxX and y < maxY then
			self:setPosition(cc.p(x + speed / math.sqrt(2), y + speed / math.sqrt(2)))
		end
	elseif self.rockerDirection == 3 then 	-- 向上走
		if y + speed > maxY then
			self:setPosition(cc.p(x, maxY))
		else
			self:setPosition(cc.p(x, y + speed))
		end
	elseif self.rockerDirection == 4 then 	-- 向左上走
		if x > minX and y >= maxY then
			self:setPosition(cc.p(x - speed, y))
		end
		if x <= minX and y >= maxY then
			self:setPosition(cc.p(minX, maxY))
		end
		if x > minX and y < maxY then
			self:setPosition(cc.p(x - speed / math.sqrt(2), y + speed / math.sqrt(2)))
		end
		if x <= minX and y < maxY then
			self:setPosition(cc.p(x, y + speed))
		end
	elseif self.rockerDirection == 5 then 	-- 向左走
		if x - speed <= minX then
			self:setPosition(cc.p(minX, y))
		else
			self:setPosition(cc.p(x - speed, y))
		end
	elseif self.rockerDirection == 6 then 	-- 向左下走
		if x <= minX and y <= minY then
			self:setPosition(cc.p(minX, minY))
		end
		if x <= minX and y > minY then
			self:setPosition(cc.p(x, y - speed))
		end
		if x > minX and y <= minY then
			self:setPosition(cc.p(x - speed, minY))
		end
		if x > minX and y > minY then
			self:setPosition(cc.p(x - speed / math.sqrt(2), y - speed / math.sqrt(2)))
		end
	elseif self.rockerDirection == 7 then 	-- 向下走
		if y - speed > minY then
			self:setPosition(cc.p(x, y - speed))
		else
			self:setPosition(cc.p(x, minY))
		end
	elseif self.rockerDirection == 8 then 	-- 向右下走
		if x >= maxX and y <= minY then
			self:setPosition(cc.p(maxX, minY))
		end
		if x >= maxX and y > minY then
			self:setPosition(cc.p(maxX, y - speed))
		end
		if x < maxX and y <= minY then
			self:setPosition(cc.p(x + speed, minY))
		end
		if x < maxX and y > minY then
			self:setPosition(cc.p(x + speed / math.sqrt(2), y - speed / math.sqrt(2)))
		end
	end
	--控制英雄的面向
	if self.faceDirection then
		self.player:setScaleX(-1)
    else
    	self.player:setScaleX(1)
	end
	if self.rockerDirection ~= 0 then 
        walk=true
        if self.player.fsm:canDoEvent("walkAction") then
            self.player.fsm:doEvent("walkAction")
        end
    end
end

function Hero:setMP(mp)
	self.MP = mp
end

function Hero:getMP()
	return self.MP
end

function Hero:setHP(hp)
	self.HP = hp
end

function Hero:getHP()
	return self.HP
end

return Hero