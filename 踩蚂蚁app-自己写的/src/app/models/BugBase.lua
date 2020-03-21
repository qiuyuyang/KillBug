
local BugBase = class("BugBase")

BugBase.BUG_TYPE_ANT = 1
BugBase.BUG_TYPE_SPIDER = 2

function BugBase:ctor()
    self.position_ = cc.p(0, 0)
    self.rotation_ = 0
    self.type_ = BugBase.BUG_TYPE_ANT
    self.dist_ = 0
    self.distPosition_ = cc.p(0, 0)
    self.speed_ = 1
    self.touchRange_ = 0
end

function BugBase:getPosition()
    return self.position_.x, self.position_.y
end

function BugBase:getRotation()
    return self.rotation_
end

function BugBase:getType()
    return self.type_
end

function BugBase:getDist()
    return self.dist_
end

function BugBase:setDistPosition(holePosition)
    self.distPosition_ = clone(holePosition)
    return self
end

function BugBase:setInitPosition(holePosition, rotation, dist)
    -- ȷ�����ӴӶ����ĸ��Ƕȳ���
    local rotation = rotation or math.random(0, 360)
    -- ȷ�������붴�ĳ�ʼ����
    -- ����͵��ȷ����ʼ�������ǱȰ����Ļ�Ŀ�ȶ�һЩ���������һ����ʱ������Ļ��
    -- �ϸ���㷨Ӧ������Ļ������ָ���Ƕ����ߵĽ������
    self.dist_ = dist or math.random(display.width / 2 + 200, display.width / 2 + 500)

    -- ������ӵĳ�ʼλ�úͽǶ�
    self.position_ = self:calcPosition_(rotation, self.dist_, holePosition)

    -- ��Ϊ��Ҫ���ӵ�ͷ���Ŷ������Գ��ӵķ���ʵ����Ҫ��ת 180 ��
    self.rotation_ = rotation - 180

    -- ����Ŀ�ĵ�λ��
    self:setDistPosition(holePosition)
    return self
end

function BugBase:step()
    -- ÿִ��һ�Σ��ó�����Ŀ�ĵط����ƶ�һ���
    self.dist_ = self.dist_ - self.speed_
    self.position_ = self:calcPosition_(self.rotation_ + 180, self.dist_, self.distPosition_)
    return self
end

function BugBase:checkTouch(x, y)
    local dx, dy = x - self.position_.x, y - self.position_.y
    local offset = math.sqrt(dx * dx + dy * dy)
    return offset <= self.touchRange_
end

function BugBase:calcPosition_(rotation, dist, distPosition)
    local radians = rotation * math.pi / 180
    return cc.p(distPosition.x + math.cos(radians) * dist,
                distPosition.y - math.sin(radians) * dist)
end

return BugBase
