--
-- Author: zyuq
-- Date: 2015-11-12 20:59:57
--
local Music = class("Music", function()
    return display.newColorLayer(cc.c4b(100, 100, 100, 0))
end)

function Music:ctor()
	self:setTouchEnabled(true)
	self:setTouchSwallowEnabled(true)
	self:setContentSize(cc.size(display.width,display.height))
	self:init()
end

Music.isPlayMusic = true
Music.isPlaySound = true
Music.SLIDER_IMAGES = {
    bar = "SliderBar.png",
    button = "SliderButton.png",
}
function Music:init()
	--版面
	local bg = display.newSprite("SetLayer.png")
	bg:setPosition(cc.p(display.cx, display.cy))
	bg:setScaleX(0.5)
	self:addChild(bg,1)
		--音乐开关
	cc.ui.UICheckBoxButton.new({on = "CheckBoxButtonOn.png",off = "CheckBoxButtonOff.png"})
		:setButtonLabel(cc.ui.UILabel.new({text = "音乐", size = 40,  color = display.COLOR_BLACK}))
        :setButtonLabelOffset(-180, 0)
        :pos(display.cx+50, display.cy+150)
        :setButtonSelected(SetLayer.isPlayMusic)
        :onButtonStateChanged(function(event)	
        	if event.state == "on" then
        		SetLayer.isPlayMusic = true
				audio.resumeMusic()
			elseif  event.state == "off" then
				SetLayer.isPlayMusic = false
				audio.pauseMusic()
			end
        	end)
        :addTo(self,4)

    --音效开关
	cc.ui.UICheckBoxButton.new({on ="CheckBoxButtonOn.png",off = "CheckBoxButtonOff.png"})
		:setButtonLabel(cc.ui.UILabel.new({text = "音效", size = 40,  color = display.COLOR_BLACK}))
        :setButtonLabelOffset(-180,0)
        :pos(display.cx+50, display.cy+50)
        :setButtonSelected(SetLayer.isPlaySound)
        :onButtonStateChanged(function(event)
        	if event.state == "on" then
        		SetLayer.isPlaySound = true
				audio.playSound("yinxiao.wav", false)
			elseif  event.state == "off" then
				SetLayer.isPlaySound = false
			end
			end)
        :addTo(self,4)

    --ok按钮
	local btn = cc.ui.UIPushButton.new({normal = "OK.png"}, {scale9 = true})
	btn:setPosition(cc.p(bg:getContentSize().width/2, 150))
	btn:setScaleX(2)
	bg:addChild(btn)
	btn:onButtonClicked(function()
		 
		self:removeFromParent()
		end)

	--音量控制滑块
	cc.ui.UISlider.new(display.LEFT_TO_RIGHT, SetLayer.SLIDER_IMAGES, {scale9 = true})
        :onSliderValueChanged(function(event)
            audio.setMusicVolume(event.value/100)
            audio.setSoundsVolume(event.value/100)
        end)
        :setSliderSize(400, 40)
        :setSliderValue(50)--默认音量70
        :align(display.LEFT_BOTTOM, bg:getContentSize().width/2-200, bg:getContentSize().height/2-50)
        :addTo(bg,4)
end

return Music