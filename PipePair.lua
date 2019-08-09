PipePair = Class{}

function PipePair:init(bottomY, pipeGap)
    self.pipeGap = pipeGap
    self.bottomY = bottomY
    self.topPipe = Pipe('top', self.bottomY)
    self.bottomPipe = Pipe('bottom', self.bottomY + self.pipeGap)
end

function PipePair:update(dt)
    self.topPipe:update(dt)
    self.bottomPipe:update(dt)

end

function PipePair:render(dt)
    self.topPipe:render()
    self.bottomPipe:render()
end
