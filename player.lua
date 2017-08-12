local player = {}

local draw = function(self)
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1, self.width/2, self.height/2);
--love.graphics.rectangle("fill", self.x - self.width / 2,self.y - self.height / 2,self.width,self.height)
--love.graphics.printf(p1joystick:getGamepadAxis("leftx"), 350, 40, 100, "center")
love.graphics.printf(p1joystick:getGamepadAxis("rightx"), 350, 60, 100, "center")
end



local update = function(self, dt)
  self.controlScheme.update(self, dt);
end



player.create = function(p1joystick, controlScheme, sprite)
  local this = {};
  this.move = {}
  this.p1joystick = p1joystick
  this.image = sprite;
  this.image:setFilter('nearest', 'nearest');
  this.width = this.image:getWidth();
  this.height = this.image:getHeight();
  this.x = 50;
  this.y = 50;
  this.controlScheme = controlScheme;
  this.currentSpeed = 0
  this.accelleration = 2
  this.maxSpeed = 200
  this.collision = HC.rectangle(this.x - this.width / 2,this.y - this.height / 2,this.width,this.height)
  this.draw = draw
  this.update = update;

  return this
end

return player
