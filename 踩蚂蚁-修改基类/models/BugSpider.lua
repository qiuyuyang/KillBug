 
local BugBase = require("src.app.models.BugBase");

local BugSpider = class("BugSpider", BugBase);
     
function BugSpider:ctor()

    BugSpider.super.ctor(self);
    self._type = BugBase.SPIDER;
    self.Hp = 1;
    self._tochRange = 60;
end

function BugSpider:getSpriteFrame()
    return "img/bug2_01.png";
end

function BugSpider:getDeadFrame()
return "img/bug2_dead.png";
end

 return BugSpider;




