ball = require 'ball'
platform = require 'platform'
bricks = require 'bricks'
walls = require 'walls'
collisions = require 'collisions'
levels = require "levels"

function love.load()
  local level = levels.require_current_level()
  bricks.construct_level( level )
  walls.construct_walls()
end

function love.update(dt)
  if love.keyboard.isDown("right") and not
    collisions.check_platform_wall_collision( platform, walls.current_level_walls["right"] ) then 
    platform.position_x = platform.position_x + (platform.speed_x * dt)
  end
  if love.keyboard.isDown("left") and not
    collisions.check_platform_wall_collision( platform, walls.current_level_walls["left"] ) then 
    platform.position_x = platform.position_x - (platform.speed_x * dt)
  end
  
  ball.update(dt)
  platform.update(dt)
  bricks.update(dt)
  walls.update(dt)
  collisions.resolve_collisions()
  
  if bricks.no_more_bricks then
     levels.switch_to_next_level( bricks )
  end
end

function love.keyreleased( key, code )
  if key == 'escape' then
    love.event.quit()
  end
  if key == 'c' then
    bricks.clear_current_level_bricks()
  end

end


function love.draw()
  local segments_in_circle = 16
   ball.draw()
   platform.draw()
   bricks.draw()
   walls.draw()
   
  if levels.gamefinished then
  love.graphics.printf( "Congratulations!\n" ..
         "You have finished the game!",
      300, 250, 200, "center" )
   end
end


function love.quit()
  print('Thanks for playing!')
end
