import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "animatedimage"

local graphics <const> = playdate.graphics
local geometry <const> = playdate.geometry

-- create animations using AnimatedImage library
local animation = {}
animation.walkS = AnimatedImage.new("spritesheet_walking", {sequence = {1, 2, 3, 4}, delay = 100, loop = true})
animation.walkN = AnimatedImage.new("spritesheet_walking", {sequence = {5, 6, 7, 8}, delay = 100, loop = true})
animation.walkW = AnimatedImage.new("spritesheet_walking", {sequence = {9, 10, 11, 12}, delay = 100, loop = true})
animation.walkE = AnimatedImage.new("spritesheet_walking", {sequence = {13, 14, 15, 16}, delay = 100, loop = true})
animation.walkNW = AnimatedImage.new("spritesheet_walking", {sequence = {17, 18, 19, 20}, delay = 100, loop = true})
animation.walkNE = AnimatedImage.new("spritesheet_walking", {sequence = {21, 22, 23, 24}, delay = 100, loop = true})
animation.walkSW = AnimatedImage.new("spritesheet_walking", {sequence = {25, 26, 27, 28}, delay = 100, loop = true})
animation.walkSE = AnimatedImage.new("spritesheet_walking", {sequence = {29, 30, 31, 32}, delay = 100, loop = true})
animation.idle = AnimatedImage.new("spritesheet_walking", {sequence = {1, 1, 1, 1, 1, 1, 25, 25, 25, 1, 1, 1, 32, 32, 1, 1, 1, 1}, delay = 200, loop = true})

-- setup input
local input_vector = geometry.vector2D.new(0, 0)

-- setup display 
playdate.display.setRefreshRate(50)

-- setup player 
local playerImage = graphics.image.new(19, 30)
local playerSprite = graphics.sprite.new(nil)
playerSprite:moveTo(200, 120) 
playerSprite:add()

-- main loop
function playdate.update()
	
	-- determine current animation from user inputs
	local current_animation = nil
	if input_vector.dy < 0 then
		current_animation = input_vector.dx < 0 and animation.walkNW or input_vector.dx > 0 and animation.walkNE or animation.walkN
	elseif input_vector.dy > 0 then
		current_animation = input_vector.dx < 0 and animation.walkSW or input_vector.dx > 0 and animation.walkSE or animation.walkS
	else
		current_animation = input_vector.dx < 0 and animation.walkW or input_vector.dx > 0 and animation.walkE or animation.idle
	end
	
	-- get current animation frame as an image
	current_image = current_animation:getImage()
	
	-- update the player sprite
	playerSprite:setImage(current_image)
	
	-- move player according to user inputs
	playerSprite:moveBy(input_vector.dx, input_vector.dy)
	
	-- update sprites
	graphics.sprite.update()
	
end

-- translate user inputs to input_vector
function playdate.leftButtonDown() input_vector.dx = -1 end
function playdate.leftButtonUp() input_vector.dx = 0 end
function playdate.rightButtonDown() input_vector.dx = 1 end
function playdate.rightButtonUp() input_vector.dx = 0 end
function playdate.upButtonDown() input_vector.dy = -1 end
function playdate.upButtonUp() input_vector.dy = 0 end
function playdate.downButtonDown() input_vector.dy = 1 end
function playdate.downButtonUp() input_vector.dy = 0 end

