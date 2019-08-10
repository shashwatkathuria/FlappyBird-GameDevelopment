Pipe = Class{}

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
