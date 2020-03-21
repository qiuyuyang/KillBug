 local BugBase = class("BugBase", function ()
       return display.newSprite("img/bug1_01.png");
end);
 BugBase.ANT = 1;
 BugBase.SPIDER = 2;

 function BugBase:ctor()
   self._position = cc.p(0, 0);
   self._rotation = 0;
   self._type = 0;
   self.Hp = 0;
   self._fSpeed = 1;
   self._tochRange = 0;

    self.dist_ = 0
    self.distPosition_ = cc.p(0, 0)
 end

 function BugBase:setPosition_(pos)
     self._position = pos;
 end

 function BugBase:getPosition_()
     return self._position;
 end

 function BugBase:getRotation_(args)
    return self._rotation;
 end

 function BugBase:getType(args)
   return self._type;
 end

 function BugBase:setDistPosition(holeposition)
 self.distPosition_ = clone(holeposition);
 end

 function BugBase:setInitPosition(holeposition, rotation, dist)
        local rotation = rotation or math.random(0, 360);
        self.dist_ = dist or math.random(display.width / 2 + 200, display.width / 2 + 500)
        
        self._position = self:calcPosition_(rotation, self.dist_, holeposition);
        self._rotation = rotation - 180;
        self:setDistPosition(holeposition);
        return self;
end
 
 function BugBase:step(args)
     self.dist_ = self.dist_ - self._fSpeed;
    self._position = self:calcPosition_(self._rotation + 180, self.dist_, self.distPosition_);
    return self._position;
 end

 function BugBase:checkTouch(x, y)
   local dx, dy = x - self._position.x, y - self._position.y
   local offset = math.sqrt(dx*dx + dy*dy);
   return offset < self._tochRange 
 end

 function BugBase:calcPosition_(rotation, dist, distPosition)
    local radians = rotation * math.pi / 180
    return cc.p(distPosition.x + math.cos(radians) * dist,
                distPosition.y - math.sin(radians) * dist)
end

 return BugBase;


