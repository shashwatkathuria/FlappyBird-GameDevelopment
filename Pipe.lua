Pipe = Class{}

function Pipe:init()
    self.image = love.graphics.newImage('pipe.png')

    self.height = self.image:getHeight()
    self.width = self.image:getWidth()

    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2

end

function Pipe:render()
    love.graphics.draw(self.image, self.x, self.y)
end
