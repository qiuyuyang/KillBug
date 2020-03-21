
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local  PlayScene = import(".PlayScene");

function MainScene:onCreate()
    -- add background image
    
        local sp = cc.Sprite:create("img/cover.jpg");
        sp:setPosition(display.cx, display.cy);
        self:addChild(sp);

        local btnPlay =  ccui.Button:create( "img/play_button.png","img/play_button.png","img/play_button.png" );
        btnPlay:setPosition(display.cx, display.cy - 200);
        self:addChild(btnPlay);

        btnPlay:addTouchEventListener(function(ref, evenType)
            if cc.EventCode.BEGAN == evenType then
            elseif cc.EventCode.ENDED == evenType then
   
               -- cc.Director:getInstance():replaceScene(import("app.views.PlayScene").new());
                display.runScene(import("app.views.PlayScene").new());
            end
        end);
   --local startScene = cc.CSLoader:getInstance():createNodeWithFlatBuffersFile("MainScene.csb"):addTo(self, 1):center()
end

return MainScene
