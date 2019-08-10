Bird = Class{}

function Bird:init()
    self.image = love.graphics.newImage('Images/bird.png')
    self.height = self.image:getHeight()
    self.width = self.image:getWidth()

    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
    self.vy = 0
end

function Bird:update(dt)

    self.vy = self.vy + GRAVITY * dt

    if love.keyboard.wasPressed('space') then
        self.vy = -5
    end

    self.y = self.y + self.vy

end

-- function Bird:jump(dt)
--
--
--
-- end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end
