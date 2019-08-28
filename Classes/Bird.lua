Bird = Class{}

function Bird:init()

    -- Initializing variables required
    self.image = love.graphics.newImage('Images/bird.png')
    self.height = self.image:getHeight()
    self.width = self.image:getWidth()

    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
    self.vy = 0

end

function Bird:update(dt)

    -- Update motion only if scrolling
    if scrolling then

        -- Updating motion
        self.vy = self.vy + GRAVITY * dt

        -- Additional jump on pressing space
        if love.keyboard.wasPressed('space') then
            self.vy = -5
        end

        self.y = self.y + self.vy

    end

end

function Bird:render()

    -- Rendering bird
    love.graphics.draw(self.image, self.x, self.y)

end
