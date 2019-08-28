PlayState = Class{__includes = BaseState}

-- Defining constants
PIPE_GAP = 80
SPAWNING_TIME = 0.9

function PlayState:init()

    -- Initalizing variables required
    self.bird = Bird()
    self.pipePairs = {}
    self.spawnCountdown = 0

    -- Randomizing seed
    math.randomseed(os.time())

    -- Inserting new pipe pair into pipe pairs table
    table.insert(self.pipePairs, PipePair(math.random(PIPE_PAIR_LOWER_LIMIT, PIPE_PAIR_UPPER_LIMIT), PIPE_GAP))

end

function PlayState:update(dt)

    -- Incrementing spawn countdown
    self.spawnCountdown = self.spawnCountdown + dt

    -- Countdown algorithm with interval as SPAWNING_TIME
    if self.spawnCountdown > SPAWNING_TIME then

        -- Inserting new pipe pair into pipe pairs table
        table.insert(self.pipePairs, PipePair(math.random(PIPE_PAIR_LOWER_LIMIT, PIPE_PAIR_UPPER_LIMIT), PIPE_GAP))
        -- Resetting countdown time to closest fractional number
        self.spawnCountdown = self.spawnCountdown % SPAWNING_TIME
    end

    -- Updating bird
    self.bird:update(dt)

    for i = 1, #self.pipePairs do

        -- Updating all pipe pairs
        self.pipePairs[i]:update(dt)
        -- Checking for collision
        if self.pipePairs[i]:collides(self.bird) then
            -- Stop scrolling if collides
            scrolling = false
        end

    end

    -- Removing pipe pairs to the left of screen
    for k, pair in pairs(self.pipePairs) do

            -- If pipe pair is not visible to the left, remove it
            if pair.bottomPipe.x + pair.bottomPipe.width < 0 then
                table.remove(self.pipePairs, k)
            end

            -- If pipe pair is not scored and bird has passed through it
            if (not pair.scored) and (pair.bottomPipe.x + pair.bottomPipe.width < self.bird.x) then

                -- Settin scored boolean of pipe pair
                pair.scored = true
                -- Incrementing score by 1
                score = score + 1

            end
    end

    -- Setting scrolling to false if bird collides with ground
    if self.bird.y + self.bird.height > VIRTUAL_HEIGHT - 16 then
        scrolling = false
    end

    -- Setting all movements to zero if not scrolling(collided)
    -- and changing state to end
    if not scrolling then
        GRAVITY = 0
        self.bird.vy = 0
        backgroundSpeed = 0
        groundSpeed = 0
        stateMachine:change('end')
    end

end

function PlayState:render()

    -- Rendering all pipe pairs
    for i = 1, #self.pipePairs do
        self.pipePairs[i]:render()
    end

    -- Rendering bird
    self.bird:render()

    -- Setting up kind of yellow color
    love.graphics.setColor(245 / 255, 236 / 255, 66 / 255, 255 / 255)
    -- Displaying score on the top left of the screen
    love.graphics.setFont(mediumFont)
    love.graphics.printf("Score : " .. tostring(score), 0, 0, VIRTUAL_WIDTH, 'left')

end
