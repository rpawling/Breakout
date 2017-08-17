local collisions = {}

function collisions.resolve_collisions()
   collisions.ball_platform_collision( ball, platform )
   collisions.ball_walls_collision( ball, walls )
   collisions.ball_bricks_collision( ball, bricks )
end

function collisions.check_rectangles_overlap( a, b )
   local overlap = false
   local shift_b_x, shift_b_y = 0, 0
   if not( a.x + a.width < b.x  or b.x + b.width < a.x  or
           a.y + a.height < b.y or b.y + b.height < a.y ) then
      overlap = true
      if ( a.x + a.width / 2 ) < ( b.x + b.width / 2 ) then
         shift_b_x = ( a.x + a.width ) - b.x                    --(*1a)
      else 
         shift_b_x = a.x - ( b.x + b.width )                    --(*1b)
      end
      if ( a.y + a.height / 2 ) < ( b.y + b.height / 2 ) then
         shift_b_y = ( a.y + a.height ) - b.y                   --(*2) 
      else
         shift_b_y = a.y - ( b.y + b.height )                   --(*2)
      end      
   end
   return overlap, shift_b_x, shift_b_y                         --(*3)
end

function collisions.ball_platform_collision( ball, platform )
   local a = { x = platform.position_x,                  --(*1)
               y = platform.position_y,
               width = platform.width,
               height = platform.height }
   local b = { x = ball.position_x - ball.radius,        --(*1)
               y = ball.position_y - ball.radius,
               width = 2 * ball.radius,
               height = 2 * ball.radius }
   overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap( a, b )   
   if overlap then
     local shift_ball = {}
     shift_ball.x = shift_ball_x
     shift_ball.y = shift_ball_y
     ball.rebound( shift_ball)
   end     
end

function collisions.ball_bricks_collision( ball, bricks )
   local b = { x = ball.position_x - ball.radius,           --(*1)
               y = ball.position_y - ball.radius,
               width = 2 * ball.radius,
               height = 2 * ball.radius }
   for i, brick in pairs( bricks.current_level_bricks ) do  --(*2)
      local a = { x = brick.position_x,                     --(*3)
                  y = brick.position_y,
                  width = brick.width,
                  height = brick.height }
      overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap( a, b )
      if overlap then
         local shift_ball = {}
         shift_ball.x = shift_ball_x
         shift_ball.y = shift_ball_y
         ball.rebound( shift_ball)
         bricks.brick_hit_by_ball( i, brick,                     --(*1)
                                   shift_ball_x, shift_ball_y )
      end
   end
end

function collisions.ball_walls_collision (ball, walls)
   local b = { x = ball.position_x - ball.radius,           --(*1)
               y = ball.position_y - ball.radius,
               width = 2 * ball.radius,
               height = 2 * ball.radius }
   for i, wall in pairs( walls.current_level_walls ) do  --(*2)
      local a = { x = wall.position_x,                     --(*3)
                  y = wall.position_y,
                  width = wall.width,
                  height = wall.height }
   overlap, shift_ball_x, shift_ball_y = collisions.check_rectangles_overlap( a, b )   
   if overlap then
     local shift_ball = {}
     shift_ball.x = shift_ball_x
     shift_ball.y = shift_ball_y
     ball.rebound( shift_ball)
   end 
   end
 end
 
function collisions.check_platform_wall_collision( platform, wall)
   local b = { x = platform.position_x,                  --(*1)
               y = platform.position_y,
               width = platform.width,
               height = platform.height }
  local a = { x = wall.position_x,                     --(*3)
              y = wall.position_y,
              width = wall.width,
              height = wall.height }
  if collisions.check_rectangles_overlap( a, b ) then   --(*4)
     return true
  end
  return false
 end
 
 return collisions