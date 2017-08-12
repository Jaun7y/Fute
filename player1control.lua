local player1control = {}


player1control.update = function(self, dt)
  if(love.keyboard.isDown('right')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.x = self.x + self.currentSpeed * dt
  end
  if(love.keyboard.isDown('left')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.x = self.x - self.currentSpeed * dt
  end
  if(love.keyboard.isDown('up')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.y = self.y - self.currentSpeed * dt
  end
  if(love.keyboard.isDown('down')) then
    if self.currentSpeed < self.maxSpeed then
      self.currentSpeed = self.currentSpeed + self.accelleration
    end
    self.y = self.y + self.currentSpeed * dt
  end
  if(love.keyboard.isDown('up') == false and
  love.keyboard.isDown('down') == false and
  love.keyboard.isDown('right') == false and
  love.keyboard.isDown('left') == false) then
    self.currentSpeed = self.currentSpeed - self.accelleration
  end
  if(self.currentSpeed < 0) then self.currentSpeed = 0 end
  self.collision:moveTo(self.x, self.y )

  --CONTROLLER
  --if p1joystick ~= nil then
    --    self.currentSpeed = 200
      --  self.x = self.x + 200 * p1joystick:getGamepadAxis("leftx")  * dt
      --  self.y = self.y + 200 * p1joystick:getGamepadAxis("lefty") * dt
  --end

  --mouse
  if love.mouse.isDown(1) then
    self.move[0], self.move[1] = love.mouse.getPosition( )
  end

  if #self.move > 0 then
    if math.abs(self.move[1] - self.y) > 1 and math.abs(self.move[0] - self.x) > 1 then
      self.currentSpeed = 200
      angle = math.atan2(self.move[1] - self.y,  self.move[0]- self.x)
      cos = math.cos(angle)
      sin = math.sin(angle)
      self.x = self.x + self.currentSpeed * cos * dt
      self.y = self.y + self.currentSpeed * sin * dt
    end
  end
end

return player1control
