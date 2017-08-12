local ball = {}



local draw = function(self)
  --love.graphics.draw(self.image, self.x, self.y, 0, 0.75, 0.75, self.width/2, self.height/2);
  love.graphics.setColor(255, 255, 255)
 love.graphics.circle("fill", self.x, self.y, self.radius)
 --love.graphics.rectangle("fill", self.x, self.y, this.width, this.width)
end

local update = function(self, dt)
  --self.x = self.x + self.speed * self.xDir * dt;
--self.y = self.y + self.speed * self.yDir * dt;
  --self.x = self.x + (self.speed * self.xDir) * dt
  if self.x + self.radius > love.graphics.getWidth() or self.x - self.radius < 0 then self.speed = self.speed * -1 self.cos = self.cos * -1 end
  if self.y - self.radius < 0 or self.y + self.radius > love.graphics.getHeight() then self.speed = self.speed * -1 self.sin = self.sin * -1 end

  --self.y = self.y + (self.speed * self.yDir) * dt
  self.x = self.x + self.xSpeed * self.cos * dt
  self.y = self.y + self.ySpeed * self.sin * dt
  self.collision:moveTo(self.x, self.y )


  --if self.ySpeed > 0 then self.ySpeed = self.ySpeed - 1 * dt end
  --if self.xSpeed > 0 then self.xSpeed = self.xSpeed - 1 * dt end
  --if self.ySpeed < 0 then self.ySpeed = self.ySpeed + 1 * dt end
  --if self.xSpeed < 0 then self.xSpeed = self.xSpeed + 1 * dt end

  --self.speed = self.speed - 1

  --if self.xSpeed < 0 then self.xSpeed = 0 end
  --if self.ySpeed < 0 then self.ySpeed = 0 end



end


local kick = function(self, cos, sin, speed)
  --self.xDir = 0
  --self.yDir = yDir
  self.speed = speed
  self.xSpeed = speed
  self.ySpeed = speed
  self.cos = cos
  self.sin = sin
end

ball.create = function()
  local this = {};
   --love.graphics.setColor(255, 255, 255)
  --this.image = love.graphics.circle("fill", this.x, this.y, 30)
  --this.image = love.graphics.newImage('ball.png');
  --this.image:setFilter('nearest', 'nearest');
  --this.width = this.image:getWidth();
  --this.height = this.image:getHeight();
  this.radius = 15
  this.x = 150;
  this.y = 130;
  this.width = 15
  this.collision = HC.circle(this.x,this.y,this.radius)
  this.speed = 0
  this.xDir = 0
  this.yDir = 0
  this.cos = 0
  this.sin = 0
  this.xSpeed = 0
  this.ySpeed = 0
  this.kick = kick
  this.draw = draw
  this.update = update

  return this

end

return ball
