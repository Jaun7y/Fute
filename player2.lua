local player2 = {}

local draw = function(self)
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width/2, self.height/2);
--love.graphics.rectangle("fill", self.x - self.width / 2,self.y - self.height / 2,self.width,self.height)
--love.graphics.printf(p1joystick:getGamepadAxis("leftx"), 350, 40, 100, "center")
if self.toMove ~= false then love.graphics.printf(self.move[0], 450, 70, 100, "center") end
love.graphics.printf(self.x, 350, 90, 100, "center")
end


local update = function(self, dt)
  if(love.keyboard.isDown('d')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.x = self.x + self.currentSpeed * dt
  end
  if(love.keyboard.isDown('a')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.x = self.x - self.currentSpeed * dt
  end
  if(love.keyboard.isDown('w')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.y = self.y - self.currentSpeed * dt
  end
  if(love.keyboard.isDown('s')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.y = self.y + self.currentSpeed * dt
  end
  if(love.keyboard.isDown('w') == false and
  love.keyboard.isDown('s') == false and
  love.keyboard.isDown('d') == false and
  love.keyboard.isDown('a') == false) then
    self.currentSpeed = self.currentSpeed - self.accelleration
  end
  if(self.currentSpeed < 0) then self.currentSpeed = 0 end
  self.collision:moveTo(self.x, self.y )

  --CONTROLLER
  --if p1joystick ~= nil then
    --    self.currentSpeed = 200
      --  self.x = self.x + 200 * p1joystick:getGamepadAxis("rightx")  * dt
        --self.y = self.y + 200 * p1joystick:getGamepadAxis("righty") * dt
    --end
--MOUSE
    if love.mouse.isDown(2) then
      self.toMove = true
      self.move[0], self.move[1] = love.mouse.getPosition( )
    end

    if self.toMove == true then
      if math.abs(self.move[1] - self.y) > 1 and math.abs(self.move[0] - self.x) > 1 then
        self.currentSpeed = 200
        angle = math.atan2(self.move[1] - self.y,  self.move[0]- self.x)
        cos = math.cos(angle)
        sin = math.sin(angle)
        self.x = self.x + self.currentSpeed * cos * dt
        self.y = self.y + self.currentSpeed * sin * dt
      end
    end
    --if(self.move == true) then
      --if (self.y == self.move[1] or self.y == self.move[1] + 2 or self.y == self.move[1] - 1)
      --and (self.x == self.move[0] or self.x == self.move[0] + 1 or self.x == self.move[0] - 1)
      --then self.toMove = false end
    --end


end



player2.create = function(p1joystick)
  local this = {};
  this.move = {}
  this.toMove = false
  this.p1joystick = p1joystick
  this.image = love.graphics.newImage('boar.png');
  this.image:setFilter('nearest', 'nearest');
  this.width = this.image:getWidth();
  this.height = this.image:getHeight();
  this.x = 50;
  this.y = 50;
  this.currentSpeed = 0
  this.accelleration = 2
  this.maxSpeed = 200
  this.collision = HC.rectangle(this.x - this.width / 2,this.y - this.height / 2,this.width,this.height)
  this.draw = draw
  this.update = update

  return this
end

return player2
