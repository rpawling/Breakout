ball = require 'ball'
platform = require 'platform'
bricks = require 'bricks'
walls = require 'walls'
collisions = require 'collisions'
levels = require "levels"

-- gamestates: menu, game, gamepaused, gamefinished
gamestate = 'menu'

function love.load()
  local level = levels.require_current_level()
  bricks.construct_level( level )
  walls.construct_walls()
end

function love.update(dt)
    if gamestate == "menu" then
    elseif gamestate == "game" then
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
    elseif gamestate == "gamepaused" then

    elseif gamestate == "gamefinished" then
    end
    
  
end

function love.keyreleased( key, code )
    if gamestate == "menu" or gamestate == "gamepaused" then
        if key == "return" then
            gamestate = "game"                                             --(*2)
        elseif key == 'escape' then
            love.event.quit()                                              --(*3)
        end    
    elseif gamestate == "game" then
        if key == 'escape' then
            love.event.quit()
        end
        if key == "return" then
            gamestate = "gamepaused"
        end
        if key == 'c' then
            bricks.clear_current_level_bricks()
        end
    elseif gamestate == "gamefinished" then
        if key == "return" then
            levels.current_level = 1
            level = levels.require_current_level()
            bricks.construct_level( level )
            ball.reposition()               
            gamestate = "game"
        elseif key == 'escape' then
            love.event.quit()
        end 
    end
end


function love.draw()
    if gamestate == "menu" then
        love.graphics.print("Menu gamestate. Press Enter to continue.", 280, 250)
    elseif gamestate == "game" then
        local segments_in_circle = 16
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
           
    elseif gamestate == 'gamepaused' then
        ball.draw()
        platform.draw()
        bricks.draw()
        walls.draw()
        love.graphics.print("Game is paused. Press Enter to continue or Esc to quit", 50, 50)
    elseif gamestate == 'gamefinished' then
        love.graphics.printf( "Congratulations!\n" ..
                 "You have finished the game!",
              300, 250, 200, "center" )
    end
end


function love.quit()
  print('Thanks for playing!')
end
