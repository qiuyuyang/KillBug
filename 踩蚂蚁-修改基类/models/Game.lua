local Game = class("Game");
local BugAnt = import(".BugAnt");
local BugSpider = require("src.app.models.BugSpider");
 
 Game.HOLE_POSITION = cc.p(display.cx - 30, display.cy - 75)

 function Game:ctor(scene)
    self._stage = scene;
    self._Hp = 5;
    self.bug = {};
    self.bugSprite = {};

 end

function Game:createBug(kind)

--[[if  #self.bugSprite > 3 then
return 
end]]

    local sp = nil;
    local type = math.random(0, 100);
    if  type < 50 then
        --sp = display.newSprite(BugAnt:getSpriteFrame()); 
        sp = BugAnt.new();
    else   
       --sp = display.newSprite(BugSpider:getSpriteFrame()); 
       sp = BugSpider.new();
    end
    sp:setInitPosition(Game.HOLE_POSITION);
    sp:setPosition(sp:getPosition_());
    sp:setRotation(sp:getRotation_());
    self._stage:addChild(sp);
        sp:setTexture(sp:getSpriteFrame());
    self.bugSprite[#self.bugSprite + 1] = sp;
    
 end
 
 function Game:touch(pos)
    
    for i = #self.bugSprite, 1, -1   do
        if self.bugSprite[i]:checkTouch(pos) then
           self:dead();
        end
    end
 end 

function Game:step()
    for i = #self.bugSprite, 1, -1 do
       local pos = self.bugSprite[i]:step();
       print("i :", i, self.bugSprite[i]:getPosition());
       self.bugSprite[i]:setPosition(pos);
 
    end
end

function Game:dead(args)
 
end



 return Game; 
 