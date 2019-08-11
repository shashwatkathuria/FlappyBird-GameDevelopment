push = require 'Libraries/push'
Class = require 'Libraries/class'

require 'Classes/Bird'
require 'Classes/Pipe'
require 'Classes/PipePair'

SPAWNING_TIME = 1

spawnCountdown = 0

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288
local latestY = 0

local background = love.graphics.newImage('Images/background.png')
local ground = love.graphics.newImage('Images/ground.png')

backgroundScroll = 0
groundScroll = 0

backgroundSpeed = 100
groundSpeed = 200

BACKGROUND_LOOPING_POINT = 413

PIPE_GAP = 80
GRAVITY = 20

PIPE_PAIR_LOWER_LIMIT = 40
PIPE_PAIR_UPPER_LIMIT = 155

local pipePairs = {}

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

    math.randomseed(os.time())
    latestY = math.random(PIPE_PAIR_LOWER_LIMIT, PIPE_PAIR_UPPER_LIMIT)
    pipePair = PipePair(latestY, PIPE_GAP)
    table.insert(pipePairs, pipePair)

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
    spawnCountdown = spawnCountdown + dt
    if spawnCountdown > SPAWNING_TIME then
      latestY = math.random(PIPE_PAIR_LOWER_LIMIT, PIPE_PAIR_UPPER_LIMIT)
      newPipePair = PipePair(latestY, PIPE_GAP)
      table.insert(pipePairs, newPipePair)
      spawnCountdown = spawnCountdown % SPAWNING_TIME
    end
    bird:update(dt)

    for i = 1, #pipePairs do
        pipePairs[i]:update(dt)
    end

    for k, pair in pairs(pipePairs) do
            if pair.bottomPipe.x + pair.bottomPipe.width < 0 then
                table.remove(pipePairs, k)
            end
    end

    for i = 1, #pipePairs do
        if pipePairs[i]:collides(bird) then
          print("Collided", os.time())
          print("\n\n\n")
        end
    end

    -- print(#pipePairs)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)

    for i = 1, #pipePairs do
        pipePairs[i]:render()
    end

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    bird:render()


    push:finish()

end
