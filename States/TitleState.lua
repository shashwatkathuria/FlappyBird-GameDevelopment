TitleState = Class{__includes = BaseState}

function TitleState:init()

    -- Initializing variables required for rendering
    -- messages specific to title state
    self.heading = "Flappy Bird"
    self.message = "Press Space to Start"
end

function TitleState:update()

    -- Changing state to countdown if space is pressed
    if love.keyboard.wasPressed('space') then
        stateMachine:change('countdown')
    end
    
end

function TitleState:render()

    -- Setting up kind of yellow color
    love.graphics.setColor(245 / 255, 236 / 255, 66 / 255, 255 / 255)

    -- Rendering messages specific to title state
    love.graphics.setFont(largeFont)
    love.graphics.printf(self.heading, 0, VIRTUAL_HEIGHT / 3 - 16, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf(self.message, 0, VIRTUAL_HEIGHT / 1.5 - 16, VIRTUAL_WIDTH, 'center')

end
