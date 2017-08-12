local playerClass = require("player")
local player2Class = require("player2")
local ballClass = require("ball")
local player1control = require('player1control')
local player2control = require('player2control')
HC = require 'HC'

local text = {}
local angle = "";
local xDir = 0
local yDir = 0
local cos = 0
local sin = 0

function love.joystickadded(joystick)
    p1joystick = joystick
end

function love.load()

  joystick = love.joystick.getJoysticks()
  player1Sprite = love.graphics.newImage('fox.png');
  player2Sprite = love.graphics.newImage('boar.png')
  player = playerClass.create(p1joystick, player1control, player1Sprite);
  player2 = playerClass.create(p1joystick, player2control, player2Sprite);
  ball = ballClass.create();
  tileset = love.graphics.newImage('map.png')
  grassQuad = love.graphics.newQuad(32, 0, 32, 32, tileset:getWidth(), tileset:getHeight())
  leftQuad = love.graphics.newQuad(128, 32, 32, 32, tileset:getWidth(), tileset:getHeight())
  topLeftQuad = love.graphics.newQuad(128, 0, 32, 32, tileset:getWidth(), tileset:getHeight())
  topRightQuad = love.graphics.newQuad(256, 0, 32, 32, tileset:getWidth(), tileset:getHeight())
  rightQuad = love.graphics.newQuad(256, 32, 32, 32, tileset:getWidth(), tileset:getHeight())
  bottomRightQuad = love.graphics.newQuad(256, 192, 32, 32, tileset:getWidth(), tileset:getHeight())
  bottomLeftQuad = love.graphics.newQuad(128, 192, 32, 32, tileset:getWidth(), tileset:getHeight())
  bottomQuad = love.graphics.newQuad(160, 192, 32, 32, tileset:getWidth(), tileset:getHeight())
  topQuad = love.graphics.newQuad(160, 0, 32, 32, tileset:getWidth(), tileset:getHeight())
end


function love.draw()

  i = 0
  x = 0
  tile = grassQuad
  while i < 20 do
    while x < 25 do
      if x == 0 and i == 0 then tile = topLeftQuad
      elseif i == 0 and x == 24 then tile = topRightQuad
      elseif i == 18 and x == 24 then tile = bottomRightQuad
      elseif i == 18 and x == 0 then tile = bottomLeftQuad
      elseif x == 0 and i ~= 0 then tile = leftQuad
      elseif x == 24 then tile = rightQuad
      elseif i == 0 and x ~= 0 then tile = topQuad
      elseif i == 18 then tile = bottomQuad
        else
          tile = grassQuad
        end

      love.graphics.draw(tileset, tile, x * 32, i * 32)
      x = x + 1
    end
    x = 0
    i = i + 1
  end

  player:draw();
  player2:draw();
  ball:draw();
  line = love.graphics.line(player.x, player.y, ball.x, ball.y)
end

function love.update(dt)

  for shape, delta in pairs(HC.collisions(player.collision)) do
    if shape == ball.collision then
      angle = math.atan2(player.y - ball.y, player.x - ball.x)
      cos = math.cos(angle + 3.14159265)
      sin = math.sin(angle + 3.14159265)
      ball:kick(cos,sin, player.currentSpeed)
    end
  end
  for shape, delta in pairs(HC.collisions(player2.collision)) do
    if shape == ball.collision then
      angle = math.atan2(player2.y - ball.y, player2.x - ball.x)
      cos = math.cos(angle + 3.14159265)
      sin = math.sin(angle + 3.14159265)
      ball:kick(cos,sin, player2.currentSpeed)
    end
  end
  print(dt);
  player:update(dt);
  player2:update(dt);
  ball:update(dt);
end
