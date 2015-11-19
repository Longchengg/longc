--
-- Author: zyuq
-- Date: 2015-11-13 11:16:56
--
local OperateLayer = class("OperateLayer", function()
	return display.newLayer()
	end)
function OperateLayer:ctor()
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:init()
end
function OperateLayer:init()
	local widget = cc.uiloader:load("OperateLayer.csb"):addTo(self, 1)

    -- 添加摇杆
    self.rockerLayer = HRocker:new()
    self.rockerLayer:pos(0, 0):addTo(self, 2)
    -- 启动摇杆
    self.rockerLayer:startRocker()

    	--暂停按钮
    self.pauseBtn = widget:getChildByName("Button_Pause")    
    self.pauseBtn : addTouchEventListener(function(psender, event)
		-- 暂停当前场景
    	cc.Director:getInstance():pause() 
    	if event == 2 then
    	-- 显示暂停面板
        local pauseLayer = PauseLayer:new()
        pauseLayer : setPosition(0,0)
        pauseLayer : addTo(self,1)
        audio.pauseMusic()
        end
    end)

    -- 普攻按钮
    local pugongBtn = widget:getChildByName("Button_PingKan")
    pugongBtn:addTouchEventListener(function()
        print(SkillData.Data.PG)
    end)
   
end

return OperateLayer