--
-- Author: zyuq
-- Date: 2015-11-12 09:29:13
--
local SetLayer = class("SetLayer", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 0))
end)

function SetLayer:ctor()
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:setContentSize(cc.size(display.width,display.height))
	self:init()
end

SetLayer.isPlayMusic = true
SetLayer.isPlaySound = true
SetLayer.SLIDER_IMAGES = {
    bar = "SliderBar.png",
    button = "SliderButton.png",
}
function SetLayer:init()
	--版面
	local bg = display.newSprite("SetLayer.png")
	bg:setPosition(cc.p(850,320))
	bg:setScaleX(0.25)
	self:addChild(bg,1)
    --返回按钮
	local btn = cc.ui.UIPushButton.new({normal = "fanhui.jpg"}, {scale9 = true})
	btn:setPosition(cc.p(bg:getContentSize().width/2, 400))
    btn:setScaleX(2)
    btn:setScaleY(0.5)
	bg:addChild(btn)
	btn:onButtonClicked(function()
		self:removeFromParent()
		end)
	--退出
	local btn = cc.ui.UIPushButton.new({normal = "tuichu.jpg"}, {scale9 = true})
	btn:setPosition(cc.p(bg:getContentSize().width/2, 350))
    btn:setScaleX(2)
    btn:setScaleY(0.5)
	bg:addChild(btn)
	btn:onButtonClicked(function()
		--切换界面到关卡选择
		end)   
    --选项
	local btn = cc.ui.UIPushButton.new({normal = "xuanxiang.jpg"}, {scale9 = true})
	btn:setPosition(cc.p(bg:getContentSize().width/2, 300))
    btn:setScaleX(2)
    btn:setScaleY(0.5)
	bg:addChild(btn)
	btn:onButtonClicked(function()
		cc.Director:getInstance():pause()--暂停
		--暂停界面
		local setLayer = Music.new()
		setLayer:setPosition(cc.p(0, 0))
		self:addChild(setLayer,2)
		end)  
	--帮助
	local btn = cc.ui.UIPushButton.new({normal = "bangzhu.jpg"}, {scale9 = true})
	btn:setPosition(cc.p(bg:getContentSize().width/2, 250))
    btn:setScaleX(2)
    btn:setScaleY(0.5)
	bg:addChild(btn)
	btn:onButtonClicked(function()
		--游戏攻略 技能介绍
		end)    
	--主菜单
	local btn = cc.ui.UIPushButton.new({normal = "zhucaidan.jpg"}, {scale9 = true})
	btn:setPosition(cc.p(bg:getContentSize().width/2, 200))
    btn:setScaleX(2)
    btn:setScaleY(0.5)
	bg:addChild(btn)
	btn:onButtonClicked(function()
		--切换界面到商店
		end)

end

return SetLayer