local levels = {}
levels.sequence = require 'levels.sequence'

levels.current_level = 1

function levels.switch_to_next_level( bricks )
    if levels.current_level < #levels.sequence then
       levels.current_level = levels.current_level + 1     
       local level = levels.require_current_level()
       bricks.construct_level( level ) 
       ball.reposition()                                                
    else
       levels.gamefinished = true
    end
end

function levels.require_current_level()
   local level_filename = "levels." .. levels.sequence[ levels.current_level ]
   local level = require( level_filename )
   return level
end

return levels