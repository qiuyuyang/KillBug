
local PlayScene = class("PlayScene",  function ()
     return display.newScene("PlayScene")
end); 

local Game = require("app.models.Game");
local PushCenter = require("app.PushCenter");



function PlayScene:ctor()
        self.Game = Game.new(self);

    -- add background image
            local sp = cc.Sprite:create("img/bg.jpg");
        sp:setPosition(display.cx, display.cy);
        self:addChild(sp);

        
       self:onNodeEvent("enter", self.onEnter);
       self:onNodeEvent("exit", self.onExit);
end

function PlayScene:onTouchBegan( pTouch, event)
      self.Game:touch( pTouch:getLocation() );
end

local function addTouchListener(self)
       local listener1 = cc.EventListenerTouchOneByOne:create()  --����һ�������¼�����
    listener1:setSwallowTouches(true)  --�Ƿ����´���
    --ע�������ص���������
    listener1:registerScriptHandler(handler(self, self.onTouchBegan),cc.Handler.EVENT_TOUCH_BEGAN )
 
    local eventDispatcher = self:getEventDispatcher() --�¼��ɷ���
    
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener1, self) --�ַ�������
end

function PlayScene:onEnter( )
      local this = self;
      addTouchListener(self);

      self:getScheduler():scheduleScriptFunc(function ( dt)
          this.Game:step(); 
          end, 0.2, false); 

      self:getScheduler():scheduleScriptFunc(function (dt)
         this.Game:createBug();     
      end, 2, false);
end

function PlayScene:onExit( )

end

return PlayScene;
