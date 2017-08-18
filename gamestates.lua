local gamestates = {}
local current_state = nil

-- elipsis forwards arguments
function gamestates.state_event( function_name, ... )
   if current_state and type( current_state[function_name] ) == 'function' then
        current_state[function_name](...)
   end
end