Pipe = Class{}

-- Leeway for player in close calls
collisionNearness = 6

function Pipe:init(orientation, y)

    -- Initializing variables required
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

    -- If bird is ahead or behind the pipe, return false
    if self.x + collisionNearness > bird.x + bird.width or bird.x + collisionNearness > self.x + self.width  then
        return false
    end

    -- If orientation is bottom
    if self.orientation == "bottom" then

        -- If bird is above the bottom pipe, return false
        if self.y + collisionNearness > bird.y + bird.height  or bird.y > self.y + self.height + collisionNearness then
            return false
        end

    -- If orientation is top
    else

        -- If bird is below top pipe's lowest point, return false
        if bird.y + collisionNearness > self.y  then
            return false
        end

    end

    -- Return true if none of the above is satisfied
    return true

end

function Pipe:update(dt)

    -- Updating pipe position
    self.x = self.x - groundSpeed * dt

end

function Pipe:render()

    -- Rendering logic for top pipe
    if self.orientation == "top" then
        love.graphics.draw(self.image, self.x + self.width, self.y, self.rotation)
    -- Rendering logic for bottom pipe
    else
        love.graphics.draw(self.image, self.x, self.y, self.rotation)
    end

end
