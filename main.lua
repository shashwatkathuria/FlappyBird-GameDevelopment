push = require 'push'
Class = require 'class'

require 'Bird'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

backgroundScroll = 0
groundScroll = 0

backgroundSpeed = 100
groundSpeed = 200

BACKGROUND_LOOPING_POINT = 413

GRAVITY = 20

JUMP_VELOCITY = 500

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Fifty Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            vsync = true,
            fullscreen = false,
            resizable = true
        })

    bird = Bird()

    love.keyboard.keysPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)

    love.keyboard.keysPressed[key] = true
    if key == "escape" then
        love.event.quit()
    end

end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + backgroundSpeed * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + groundSpeed * dt) % VIRTUAL_WIDTH
    bird:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    bird:render()

    push:finish()

end
