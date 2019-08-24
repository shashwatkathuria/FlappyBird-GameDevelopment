Pipe = Class{}

collisionNearness = 4

function Pipe:init(orientation, y)
    self.image = love.graphics.newImage('Images/pipe.png')

    self.height = self.image:getHeight()
    self.width = self.image:getWidth()
    self.margin = 50

    self.orientation = orientation
    if orientation == "top" then
        self.rotation = -math.pi
    else
        self.rotation = 0
    end
    self.x = VIRTUAL_WIDTH
    self.y = y

end

function Pipe:collides(bird, pipeGap)

    if self.x + collisionNearness > bird.x + bird.width or bird.x + collisionNearness > self.x + self.width  then
      return false
    end
    if self.orientation == "bottom" then
        if self.y + collisionNearness > bird.y + bird.height  or bird.y > self.y + self.height + collisionNearness then
          return false
        end
    else
        if bird.y + collisionNearness > self.y  then
          return false
        end
    end

    return true
end

function Pipe:update(dt)
    self.x = self.x - groundSpeed * dt

end

function Pipe:render()
    if self.orientation == "top" then
        love.graphics.draw(self.image, self.x + self.width, self.y, self.rotation)
    else
        love.graphics.draw(self.image, self.x, self.y, self.rotation)
    end

end
