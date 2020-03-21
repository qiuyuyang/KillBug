local MainScene = class("MainScene", cc.load("mvc").ViewBase);
local PlayScene = import("app.views.PlayScene");

function MainScene:ctor()
        local sp = display.newSprite("img/cover.jpg");
        sp:setPosition(display.cx, display.cy);
        self:addChild(sp);
        
        local sp1 =  ccui.Button:create( "img/play_button.png","img/play_button.png","img/play_button.png" );
        sp1:setPosition(display.cx, display.cy - 200);
        self:addChild(sp1);

      sp1:addTouchEventListener(function(ref, evenType)
            if cc.EventCode.BEGAN == evenType then
            elseif cc.EventCode.ENDED == evenType then
                local playScene2 = PlayScene.new() ;
                 
                print(" : ", display, display.replaceScene, import("app.views.PlayScene"), playScene2);
              cc.Director:getInstance():replaceScene(import("app.views.PlayScene").new()); -- display.replaceScene(playScene2)
            end
        end);
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
