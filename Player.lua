--
-- Author: zyuq
-- Date: 2015-11-16 17:01:32
--
local Player = class("Player", function()
	return display.newSprite()
end)

function Player:ctor()
	for k,v in pairs(HeroData.defaultData) do
		self[k] = v
	end
	self:init()
		
end

function Player:init()
	self.fsm = {}
    cc.GameObject.extend(self.fsm)
        :addComponent("components.behavior.StateMachine")
        :exportMethods()
	self.fsm:setupState({
        events = {
            {name = "stopAction", from = {"none", "walk"},   to = "stop" },
            {name = "walkAction", from = "stop",   to = "walk" },
        },

        callbacks = {
            onbeforestopAction	= function(event) self:stopAllActions() end,
            onleavenone 		= function(event)  end,
            onenterstop      	= function(event) self:stop() end,
            onafterstopAction 	= function(event)  end,

            onbeforewalkAction	= function(event) self:stopAllActions() end,
            onleavestop 		= function(event)  end,
            onenterwalk      	= function(event) self:walk() end,
            onafterwalkAction 	= function(event)  end,
        },
    })
end

-- 待机站立
function Player:stop()	
	self:packagingAnimation("daiji")
end

--跑动
function Player:walk()
	self:packagingAnimation("paobu")
end

-- 封装动画
function Player:packagingAnimation(animationName)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("Hero/"..animationName.."/"..animationName..".ExportJson")
    local armature = ccs.Armature:create(animationName)
    armature:getAnimation():playWithIndexes({"0"}, 0, true)  
    if self:getChildByTag(101) then
    	self:getChildByTag(101):removeFromParent()
    end
    armature:setTag(101)
    self:addChild(armature, 2)
end

return Player