-- Importing required libraries
push = require 'Libraries/push'
Class = require 'Libraries/class'

-- Importing required classes
require 'Classes/Bird'
require 'Classes/Pipe'
require 'Classes/PipePair'
require 'Classes/StateMachine'

-- Importing required states
require 'States/BaseState'
require 'States/PlayState'
require 'States/TitleState'
require 'States/CountDownState'
require 'States/EndState'

-- Initializing global window constants
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- Initializing local images
local background = love.graphics.newImage('Images/background.png')
local ground = love.graphics.newImage('Images/ground.png')

-- Variables required for scrolling
backgroundScroll = 0
groundScroll = 0
backgroundSpeed = 100
groundSpeed = 200
BACKGROUND_LOOPING_POINT = 413

-- Variables for pipe and bird physics
PIPE_GAP = 80
PIPE_PAIR_LOWER_LIMIT = 40
PIPE_PAIR_UPPER_LIMIT = 155
GRAVITY = 20
JUMP_VELOCITY = 500

-- Variables to be modified during program
local pipePairs = {}
score = 0
scrolling = true

function love.load()

    -- Filter to be nearest
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Setting window title
    love.window.setTitle('Flappy Bird')

    -- Setting up screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            vsync = true,
            fullscreen = false,
            resizable = true
        })

    -- Defining fonts
    smallFont = love.graphics.newFont('Fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('Fonts/font.ttf', 16)
    largeFont = love.graphics.newFont('Fonts/font.ttf', 64)

    -- Setting font
    love.graphics.setFont(largeFont)

    -- Defining state machine with all states
    stateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['title'] = function() return TitleState() end,
        ['countdown'] = function() return CountDownState() end,
        ['end'] = function() return EndState() end
    }

    -- Initializing state machine with title state
    stateMachine:change('title')

    -- Initalizing keys pressed
    love.keyboard.keysPressed = {}

end

function love.resize(w, h)

    -- Resizing screen
    push:resize(w, h)

end

function love.keypressed(key)

    -- Keeping track of keys pressed in each frame
    love.keyboard.keysPressed[key] = true

    -- Quitting application on escape
    if key == "escape" then
        love.event.quit()
    end

end

function love.keyboard.wasPressed(key)

    -- Returning whether or not the key was pressed in current frame
    return love.keyboard.keysPressed[key]

end

function love.update(dt)

    -- Scrolling background and ground with limit as respective looping points
    backgroundScroll = (backgroundScroll + backgroundSpeed * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + groundSpeed * dt) % VIRTUAL_WIDTH

    -- Updating state machine
    stateMachine:update(dt)

    -- Resetting keys pressed
    love.keyboard.keysPressed = {}

end

function love.draw()

    push:start()

    -- Background to be rendered always
    love.graphics.draw(background, -backgroundScroll, 0)

    -- Rendering appropriate state in state machine
    stateMachine:render()

    -- Ground to be rendered always, on top of background
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    push:finish()

end
