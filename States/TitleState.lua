TitleState = Class{__includes = BaseState}

function TitleState:init()
    self.heading = "Flappy Bird"
    self.message = "Press Space to Start"
end

function TitleState:update()
    if love.keyboard.wasPressed('space') then
        stateMachine:change('play')
    end
end

function TitleState:render()
    love.graphics.setColor(245 / 255, 236 / 255, 66 / 255, 255 / 255)
    love.graphics.setFont(largeFont)
    love.graphics.printf(self.heading, 0, VIRTUAL_HEIGHT / 3 - 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf(self.message, 0, VIRTUAL_HEIGHT / 1.5 - 16, VIRTUAL_WIDTH, 'center')

end
