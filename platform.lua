local platform = {}
platform.position_x = 500
platform.position_y = 500
platform.speed_x = 500
platform.width = 70
platform.height = 20

function platform.update(dt)
end

function platform.draw()
   love.graphics.rectangle( 'line',
        platform.position_x,
        platform.position_y,
        platform.width,
        platform.height )
end

return platform