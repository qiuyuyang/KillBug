
local BugBase =  import(".BugBase");
 local  BugAnt = class("BugAnt", BugBase);

 function BugAnt:ctor(args)
    BugAnt.super.ctor(self);
    self._type = BugBase.ANT;
    self._touchRange = 60;
    self._Hp = 1;  
 end

 function BugAnt:getSpriteFrame()
        return "img/bug1_01.png"
 end

 function BugAnt:getDeadFrame(args)
     return "img/bug1_dead.png"
 end

 return BugAnt;