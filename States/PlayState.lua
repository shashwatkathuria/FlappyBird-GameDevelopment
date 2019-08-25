PlayState = Class{__includes = BaseState}

PIPE_GAP = 80
function PlayState:init()

    self.bird = Bird()
    self.pipePairs = {}
    self.spawnCountdown = 0

    math.randomseed(os.time())

    self.latestY = math.random(PIPE_PAIR_LOWER_LIMIT, PIPE_PAIR_UPPER_LIMIT)
    table.insert(self.pipePairs, PipePair(self.latestY, PIPE_GAP))

end

function PlayState:update(dt)
    self.spawnCountdown = self.spawnCountdown + dt
    if self.spawnCountdown > SPAWNING_TIME then
        self.latestY = math.random(PIPE_PAIR_LOWER_LIMIT, PIPE_PAIR_UPPER_LIMIT)
        table.insert(self.pipePairs, PipePair(self.latestY, PIPE_GAP))
        self.spawnCountdown = self.spawnCountdown % SPAWNING_TIME
    end
    self.bird:update(dt)

    for i = 1, #self.pipePairs do
        self.pipePairs[i]:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
            if pair.bottomPipe.x + pair.bottomPipe.width < 0 then
                table.remove(self.pipePairs, k)
            end
            if (not pair.scored) and (pair.bottomPipe.x + pair.bottomPipe.width < self.bird.x) then
                pair.scored = true
                score = score + 1
            end
    end

    for i = 1, #self.pipePairs do
        if self.pipePairs[i]:collides(self.bird) then
            scrolling = false
        end
    end

    if self.bird.y + self.bird.height > VIRTUAL_HEIGHT - 16 then
        scrolling = false
    end

    if not scrolling then
        GRAVITY = 0
        self.bird.vy = 0
        backgroundSpeed = 0
        groundSpeed = 0
        stateMachine:change('end')
    end

end

function PlayState:render()
    for i = 1, #self.pipePairs do
        self.pipePairs[i]:render()
    end
    self.bird:render()

    love.graphics.setColor(245 / 255, 236 / 255, 66 / 255, 255 / 255)
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Score : " .. tostring(score), 0, 0, VIRTUAL_WIDTH, 'left')
end
