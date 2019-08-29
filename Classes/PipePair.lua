PipePair = Class{}

function PipePair:init(bottomY, pipeGap)

    -- Initializing variables required
    self.pipeGap = pipeGap
    self.bottomY = bottomY
    self.topPipe = Pipe('top', self.bottomY)
    self.bottomPipe = Pipe('bottom', self.bottomY + self.pipeGap)

    self.scored = false

end

function PipePair:collides(bird)

    -- Return true if either one collides
    return self.bottomPipe:collides(bird) or self.topPipe:collides(bird, self.pipeGap)

end

function PipePair:update(dt)

    -- Updating both top and bottom pipe
    self.topPipe:update(dt)
    self.bottomPipe:update(dt)

end

function PipePair:render(dt)

    -- Rendering both top and bottom pipe
    self.topPipe:render()
    self.bottomPipe:render()

end
