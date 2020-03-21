
local PlayScene = class("PlayScene", function()
    return display.newScene("PlayScene")
end)

local Game = require("app.models.Game")
cc.exports.PushCenter = require("src.app.PushCenter");
    

function PlayScene:ctor()

   self.game_ = Game.new(self)

    local bg = display.newSprite("img/bg.jpg");
        bg:setPosition(display.cx, display.cy)
        self:addChild(bg);

    local star = display.newSprite("img/star.png")
        star:setPosition(display.left + 50, display.top - 50)
        self:addChild(star)

    --self.starsLabel_ = nil;

        self.starsLabel_  = cc.Label:createWithSystemFont(self.game_:getStars(), "Arial", 40)
        :move(display.left + 90, display.top - 50)
        :addTo(self)

       self:onNodeEvent("enter", self.onEnter);
       self:onNodeEvent("exit", self.onExit);
end

 function PlayScene:onTouchBegan(pTouch,event)
 print("self  game_:", self, self.game_);

  print(" pTouch  event:", pTouch:getLocation(), pTouch:getLocation().x, event.name);

          self.game_:onTouch(pTouch:getLocation())
end

local  function addTouchListenerEvent(self)
local this = self;
   local listener1 = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
    listener1:setSwallowTouches(true)  --是否向下传递
    --注册三个回调监听方法
    listener1:registerScriptHandler(handler(self, self.onTouchBegan),cc.Handler.EVENT_TOUCH_BEGAN )
 
    local eventDispatcher = self:getEventDispatcher() --事件派发器
    
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, self) --分发监听事
 
end



function PlayScene:onEnter()
    local this = self;
    PushCenter.addListener("BUG_ENTER_HOLE_EVENT", function(event)
        self.starsLabel_:setString(self.game_:getStars())
    end, self)

    PushCenter.addListener("PLAYER_DEAD_EVENT", handler(self, self.onPlayerDead_), self)


     self:getScheduler():scheduleScriptFunc( function(dt)
                                                this.game_:step()
                                                end, 0.02, false);
                                            
     
        self:getScheduler():scheduleScriptFunc( function(dt)
                                                    this.game_:addBug()
                                                    print("===2");
                                                    end, 2, false);
 

   --[[ self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return this.game_:onTouch(event)
    end)]]
    addTouchListenerEvent(self);
end
 
function PlayScene:onExit()
end

function PlayScene:onPlayerDead_()
print("--------------------------------game over");
    local text = string.format("你戳死了 %d 只虫子", self.game_:getDeadCount())
    cc.ui.UILabel.new({text = text, size = 96})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)

    cc.ui.UIPushButton.new("img/exit_button.png")
        :onButtonClicked(function()
            app:enterScene("MainScene", nil, "Random", 1.0)
        end)
        :pos(display.cx, display.cy - 200)
        :addTo(self)
end

return PlayScene
