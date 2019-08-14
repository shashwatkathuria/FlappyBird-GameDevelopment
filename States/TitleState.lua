TitleState = Class{__includes = BaseState}

function TitleState:init()
    self.heading = "Flappy Bird"
    self.message = "Press Space to Continue"
end

function TitleState:update()
    if love.keyboard.wasPressed('space') then
        stateMachine:change('play')
    end
end

function TitleState:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf(self.heading, 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf(self.message, 0, VIRTUAL_HEIGHT - 16, VIRTUAL_WIDTH, 'center')

end
