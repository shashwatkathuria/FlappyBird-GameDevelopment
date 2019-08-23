EndState = Class{ __includes = BaseState }

function EndState:init()
    self.message = "Press Enter to Play Again"
end

function EndState:update(dt)

    if love.keyboard.wasPressed('return') then
        stateMachine:change('title')

        score = 0
        backgroundSpeed = 100
        groundSpeed = 200
        GRAVITY = 20
        scrolling = true

    end
end

function EndState:render()
  love.graphics.setColor(245 / 255, 236 / 255, 66 / 255, 255 / 255)
  love.graphics.setFont(largeFont)
  love.graphics.printf("Score : " .. tostring(score), 0, VIRTUAL_HEIGHT / 3 - 16, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(mediumFont)
  love.graphics.printf(self.message, 0, VIRTUAL_HEIGHT / 1.5 - 16, VIRTUAL_WIDTH, 'center')
end
