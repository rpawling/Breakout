local ball = {}
local vector = require "hump.vector"

ball.position_x = 300
ball.position_y = 300
ball.speed = vector(300, 300)
ball.radius = 10

function ball.reposition()
   ball.position_x = 200
   ball.position_y = 500   
end

function ball.update( dt )
   ball.position_x = ball.position_x + ball.speed.x * dt
   ball.position_y = ball.position_y + ball.speed.y * dt   
end

function ball.rebound( shift_ball )
   local min_shift = math.min( math.abs( shift_ball.x ),
                               math.abs( shift_ball.y ) )
   if math.abs( shift_ball.x ) == min_shift then
      shift_ball.y = 0
   else
      shift_ball.x = 0
   end
   ball.position_x = ball.position_x + shift_ball.x
   ball.position_y = ball.position_y + shift_ball.y
   if shift_ball.x ~= 0 then
      ball.speed.x = -ball.speed.x
   end
   if shift_ball.y ~= 0 then
      ball.speed.y = -ball.speed.y
   end
end

function ball.draw()
   local segments_in_circle = 16
   love.graphics.circle( 'line',
       ball.position_x,
       ball.position_y,
       ball.radius,
       segments_in_circle )   
end

return ball