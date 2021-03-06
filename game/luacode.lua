--[[
Amble: a platformer game being made as a hobby.
Copyright (C) 2015, 2016 Frozelar

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

getmetatable('').__index = function(str, i)
	return string.sub(str, i, i)
end

game_title = "Amble"

totalLevels = 2  -- INCLUDING title screen level!

resourceDirectory = "resources/"
resourceExtension = ".png"
title_font = {"AveriaSans-Regular.ttf", 72, math.random(0, 255), math.random(0, 255), math.random(0, 51), 255}
heading_font = {"AveriaSans-Regular.ttf", 36, 255, 255, 255, 255}	-- name, size, r, g, b, a
body_font = {"AveriaSans-Regular.ttf", 18, 255, 255, 255, 255}

-- textColor = { 255, 255, 255, 255 }  -- r, g, b, a
highlightColor = { 210, 180, 90, 255 }

direction = { "left", "right", "up", "down" }

thingTypes = { "player", "tile", "enemy", "collectible" }

-- TILE_OFFSET = 10
tileTypes = { "DirtBlock", "DirtWall", "CloudBlock" }
TOTAL_TILE_TYPES = #tileTypes

-- ENEMY_OFFSET = 100
enemyTypes = { "Bean", "Daub", "Cragore" }
TOTAL_ENEMY_TYPES = #enemyTypes
enemyStats = { {100, 1}, {75, 5}, {200, 10} }		-- order corresponds to enemyTypes; format = {health, power}
HEALTH_INDEX = 1
POWER_INDEX = 2

-- COLLECTIBLE_OFFSET = 200
collectibleTypes = { "Bit", "Byte", "Jumpbit", "Strikebit" }
TOTAL_COLLECTIBLE_TYPES = #collectibleTypes

particleTypes = { "Red", "Gray", "Blue", "BigRed", "BigGray", "BigBlue" }
TOTAL_PARTICLE_TYPES = #particleTypes

projectileTypes = { "Dot", "Redot", "Speedot" }
TOTAL_PROJECTILE_TYPES = #projectileTypes

-- {name, # frames or # frame sets}
graphicsIdentifiers = { 
	{ {"Title", 1}, {"Underground", 1}, {"Sky", 1}, {"Autumn", 1} }, -- backgrounds (# frames)
	{ {"DirtBlock", 1}, {"DirtWall", 1}, {"CloudBlock", 1} }, -- tiles (# frames (PER tile subidentifier))
	{ {"" --[[ "Player" ]], 5} }, -- player states (# frame SETS (5 by default)
	{ {"Bean", 5}, {"Daub", 5}, {"Cragore", 5} }, -- enemies (# frame SETS (5 by default))
	{ {"Bit", 4}, {"Byte", 4}, {"Jumpbit", 4}, {"Strikebit", 4} }, -- collectibles (# frames)
	{ {"Red", 2}, {"Gray", 2}, {"Blue", 2}, {"BigRed", 2}, {"BigGray", 2}, {"BigBlue", 2} }, -- particles (# frames)
	{ {"Dot", 2}, {"Redot", 2}, {"Speedot", 2} }	-- projectiles (# frames)
}

tileSubIdentifiers = {
	"Center", "Top", "TopRight", "Right", "BottomRight", "Bottom", "BottomLeft", "Left", "TopLeft", 
	--[[ "Single",
	"SlopeTopLeft", "SlopeTopRight", "SlopeBottomLeft", "SlopeBottomRight" ]]
}
TOTAL_TILE_SUBTYPES = #tileSubIdentifiers

-- {name}
audioIdentifiers = { 
	{ "Jump", "Explosion", "Collect", "Hurt", "Powerup", "Select", "Whoosh", "Warp", "Dash" }, -- sfx
	{ "Title", "Underground" } -- music 
}

audioBuffer = {
	{},	-- sfx
	{}	-- music
}
SFX_INDEX = 1
MUSIC_INDEX = 2

-- {name, # frames}
frameIdentifiers = {
	{ {"Idle", 4}, {"WalkLeft", 4}, {"WalkRight", 4}, {"Jump", 2}, {"Fall", 2} }, -- most entities (currently only used with enemies and players)
	{ {"Default", 4} } -- most objects (CURRENTLY UNUSED, CHANGE FRAMES IN graphicsIdentifiers INSTEAD)
}

-- backgroundFrames = {}
entityFrames = {}
objectFrames = {}

gravityArray = { 0, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8 }
TOTAL_GRAVITY_ARRAY_UNITS = #gravityArray

jumpArray = { 8, 8, 8, 7, 7, 6, 6, 5, 5, 5, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 0 }
TOTAL_JUMP_ARRAY_UNITS = #jumpArray

dashArray = { 16, 16, 12, 8, 6, 4, 2, 2, 1 }
TOTAL_DASH_ARRAY_UNITS = #dashArray

floatArray = { 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, -1, -1 }
TOTAL_FLOAT_ARRAY_UNITS = #floatArray

FPS = 60
GFX_SCALE = 1.0
GFX_MULT = 1.0
WINDOW_W = 960
WINDOW_H = 540
DEFAULT_W = 8 * 2
DEFAULT_H = 8 * 2
PLAYER_W = 8 * 2
PLAYER_H = 16 * 2
DEFAULT_ENEMY_W = 8 * 2
DEFAULT_ENEMY_H = 8 * 2
DEFAULT_COLLECTIBLE_W = 8 * 2
DEFAULT_COLLECTIBLE_H = 8 * 2
DEFAULT_GFX_OFFSET = 2 * 2
DEFAULT_SPEED = 2
DEFAULT_COOLDOWN = 128
DEFAULT_PARTICLE_W = 1 * 2
DEFAULT_PARTICLE_H = 1 * 2
DEFAULT_PROJECTILE_W = 2 * 2
DEFAULT_PROJECTILE_H = 2 * 2
DEFAULT_PROJECTILE_LIFE = 300

LEVEL_UNITS = 0
LEVEL_W = 0
LEVEL_H = 0

-- gPlayer = nil
things = {}

points = 0

Point = { x = 0, y = 0 }
Point.__index = Point

setmetatable(Point, {
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Point:new(px, py)
	self.x = px
	self.y = py
end

function Point:__eq(other)
	self.x = other.x
	self.y = other.y
end

PolarPoint = { r = 0, angle = 0 }
PolarPoint.__index = PolarPoint

setmetatable(PolarPoint, {
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function PolarPoint:new(pr, pang)
	self.r = pr
	self.angle = pang
end

function Point:__eq(other)
	self.r = other.r
	self.angle = other.angle
end

Rectangle = { x = 0, y = 0, w = 0, h = 0 }
Rectangle.__index = Rectangle

setmetatable(Rectangle, {
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Rectangle:new(px, py, pw, ph)
  self.x = px
  self.y = py
  self.w = pw
  self.h = ph
end

function Rectangle:__eq(other)
  self.x = other.x
  self.y = other.y
  self.w = other.w
  self.h = other.h
end

Background = { bgType, bgRect, bgFrame, bgFrameInterval, bgMaxFrames }
Background.__index = Background

setmetatable(Background, {
	-- __index = Rectangle,
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Background:new()
	self.bgRect = Rectangle(0, 0, WINDOW_W, WINDOW_H)
	self.bgType = -1
	self.bgFrame = 1
	self.bgFrameInterval = 1
	self.bgMaxFrames = -1
end

--[[
function Background:bgSetType(pType)
	self.bgType = pType
	self.bgMaxFrames = graphicsIdentifiers[1][self.bgType][2]
end
]]

function bgSetType(pType)
	gBackground.bgType = pType
	gBackground.bgMaxFrames = graphicsIdentifiers[1][gBackground.bgType][2]
end

function Background:bgCycleFrames()
	if self.bgFrameInterval % 4 == 0 then
		self.bgFrame = self.bgFrame + 1
		self.bgFrameInterval = 0
	end
	if self.bgFrame > self.bgMaxFrames then
		self.bgFrame = 1
		self.bgFrameInterval = 0
	end
end

Projectile = { pjType, pjSpeed, pjVerticals, pjRect, pjFrame, pjFrameInterval, pjMaxFrames, pjWhatShotIt, pjPower }
Projectile.__index = Projectile

setmetatable(Projectile, {
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Projectile:new(pType, px, py, pWhat, pDirection)
	self.pjType = pType
	self.pjRect = Rectangle(px, py, DEFAULT_PROJECTILE_W, DEFAULT_PROJECTILE_H)
	if pDirection == "right" then
		if projectileTypes[pType] == "Speedot" then
			self.pjSpeed = DEFAULT_SPEED * 2
		else
			self.pjSpeed = DEFAULT_SPEED
		end
		self.pjVerticals = 0
	elseif pDirection == "left" then
		if projectileTypes[pType] == "Speedot" then
			self.pjSpeed = -DEFAULT_SPEED * 2
		else
			self.pjSpeed = -DEFAULT_SPEED
		end
		self.pjVerticals = 0
	elseif pDirection == "up" then
		self.pjSpeed = 0
		self.pjVerticals = -1
	elseif pDirection == "down" then
		self.pjSpeed = 0
		self.pjVerticals = 1
	end
	self.pjWhatShotIt = pWhat
	self.pjFrame = 1
	self.pjFrameInterval = 0
	self.pjMaxFrames = graphicsIdentifiers[7][self.pjType][2]
	
	if thingTypes[pWhat] == "player" then
		pjPower = things[gPlayerUnit].plPower
	elseif thingTypes[pWhat] == "enemy" then
		if projectileTypes[pType] == "Dot" then
			self.pjPower = 5
		elseif projectileTypes[pType] == "Redot" then
			self.pjPower = 10
		elseif projectileTypes[pType] == "Speedot" then
			self.pjPower = 10
		end
	end
end

function Projectile:pjCycleFrames()
	if self.pjFrameInterval > 4 then
		self.pjFrame = self.pjFrame + 1
		self.pjFrameInterval = 0
	end
	if self.pjFrame > self.pjMaxFrames then
		self.pjFrame = 1
		self.pjFrameInterval = 0
	end
	self.pjFrameInterval = self.pjFrameInterval + 1
end

function Projectile:pjMove()
	local t = projectileTypes[self.pjType]
	
	if t == "Dot" then
		self.pjRect.x = self.pjRect.x + self.pjSpeed
	elseif t == "Redot" then
		self.pjRect.x = self.pjRect.x + self.pjSpeed
	elseif t == "Speedot" then
		self.pjRect.x = self.pjRect.x + self.pjSpeed
	end
end

function pjResolveCollision(whichProj, whichThing)
	local t = projectileTypes[gProjectiles[whichProj].pjType]
	
	if t == "Dot" or t == "Redot" or t == "Speedot" then
		if whichThing ~= -1 and things[whichThing].tgType ~= "tile" then
			playAudio(SFX_INDEX, "Hurt")
		end
	end
end

Particle = { ptType, ptRect, ptDestination, --[[ptLife,]] ptSpeedX, ptSpeedY, ptFrame, ptFrameInterval, ptMaxFrames }
Particle.__index = Particle

setmetatable(Particle, {
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Particle:new(pType, px, py)
	-- local rectdest = Point(0, 0)
	
	self.ptRect = Rectangle(px, py, 0, 0)
	if string.sub(particleTypes[pType], 1, 3) == "Big" then
		self.ptRect.w = DEFAULT_PARTICLE_W * 2
		self.ptRect.h = DEFAULT_PARTICLE_H * 2
	else
		self.ptRect.w = DEFAULT_PARTICLE_W
		self.ptRect.h = DEFAULT_PARTICLE_H
	end
	
	self.ptType = pType	
	self.ptDestination = Point(px + math.random(-8, 8), py + math.random(-8, 8))
	self.ptSpeedX = (self.ptDestination.x - self.ptRect.x)-- - math.random(-8, 8) -- - math.random(1, math.abs(math.floor(self.ptDestination.x - self.ptRect.x)) + 1)
	if self.ptSpeedX == 0 then
		if math.random(0, 1) == 0 then
			self.ptSpeedX = 1
		else
			self.ptSpeedX = -1
		end
	end
	self.ptSpeedY = (self.ptDestination.y - self.ptRect.y)-- - math.random(-8, 8) -- - math.random(1, math.abs(math.floor(self.ptDestination.y - self.ptRect.y)) + 1)
	if self.ptSpeedY == 0 then
		if math.random(0, 1) == 0 then
			self.ptSpeedY = 1
		else
			self.ptSpeedY = -1
		end
	end
	--[[
	self.ptDestination = rectToPolar(Point(px + math.random(-8, 8), py + math.random(-8, 8)))  --Point(px + math.random(-8, 8), py + math.random(-8, 8))
	if self.ptDestination.angle < 0 then
		self.ptDestination.angle = self.ptDestination.angle + 360
	end
	rectdest = polarToRect(self.ptDestination)
	-- self.ptSpeed = math.random(1, 4)
	self.ptSpeedX = (polarToRect(self.ptDestination).x - self.ptRect.x) - math.random(1, math.abs(math.floor(rectdest.x - self.ptRect.x)) + 1)
	self.ptSpeedY = (polarToRect(self.ptDestination).y - self.ptRect.y) - math.random(1, math.abs(math.floor(rectdest.y - self.ptRect.y)) + 1)
	]]
	-- self.ptLife = ((px - self.ptDestination.x) + (py - self.ptDestination.y)) / ptSpeed
	self.ptFrame = 1
	self.ptFrameInterval = 0
	self.ptMaxFrames = graphicsIdentifiers[6][self.ptType][2]
end

function Particle:ptCycleFrames()
	if self.ptFrameInterval > 4 then
		self.ptFrame = self.ptFrame + 1
		self.ptFrameInterval = 0
	end
	if self.ptFrame > self.ptMaxFrames then
		self.ptFrame = 1
		self.ptFrameInterval = 0
	end
	self.ptFrameInterval = self.ptFrameInterval + 1
end

Thing = { tgType, tgVerticals, tgSpeed, tgHitbox, tgLevelUnit, tgThingsUnit, tgHealth, tgFrame, tgFrameInterval, tgMaxFrames, tgColliding, tgColDir }
Thing.__index = Thing

setmetatable(Thing, {
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Thing:new(levelUnit, thingsUnit)
  self.tgType = 0
  self.tgVerticals = 0
  self.tgSpeed = 0
  self.tgLevelUnit = levelUnit
  self.tgThingsUnit = thingsUnit
  self.tgHitbox = Rectangle(0, 0, 0, 0)
  self.tgFrame = 1
  self.tgFrameInterval = 0
  self.tgColliding = { -1, -1, -1, -1 }		-- index for each direction
  self.tgHealth = 100
  self.tgDashing = 0
  -- self.tgMaxFrames = 0
  --[[
  local lx, ly, amt = self.tgLevelUnit, self.tgLevelUnit, 0
  while lx >= LEVEL_W do
	lx = lx - LEVEL_W
	amt = amt + 1
  end
  self.tgHitbox.x = lx * DEFAULT_W
  self.tgHitbox.y = amt * DEFAULT_H
	]]
end

Player = {plJumps, plActionFrames, plPower, tgDashing}
Player.__index = Player

setmetatable(Player, {
	__index = Thing,
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Player:new(levelUnit, thingsUnit)
  --self.tgType = thingTypes["player"]
  self.tgType = "player"
  self.tgVerticals = 0
  self.tgSpeed = 0
  self.tgLevelUnit = levelUnit
  self.tgThingsUnit = thingsUnit
  self.tgFrame = 1
  self.tgFrameInterval = 0
  self.tgHealth = 100
  self.tgColliding = { -1, -1, -1, -1 }
  self.plJumps = 0
  self.plActionFrames = 1
  self.tgDashing = 0
  self.plPower = 10
  self.tgHitbox = Rectangle(0, 0, 0, 0)
  self.tgHitbox.w = PLAYER_W
  self.tgHitbox.h = PLAYER_H
end

function Player:plCycleFrames()
	local frameChange = ""
	self.tgFrameInterval = self.tgFrameInterval + 1
	-- if (speed ~= 0 and 4 frames have passed) or (frame == Idle1 and 64 frames have passed) or (thing is idle but is not on the first or last idle frame and 16 frames have passed) then (increment the frame and reset the frame counter)
	if ((self.tgSpeed ~= 0 or self.tgVerticals ~= 0) and self.tgFrameInterval % 4 == 0) or 
	(entityFrames[self.tgFrame] == "Idle1" and self.tgFrameInterval % 64 == 0) or
	(string.sub(entityFrames[self.tgFrame], 1, 4) == "Idle" and string.find(entityFrames[self.tgFrame], "1", 5) == nil --[[ and string.find(entityFrames[self.tgFrame], "4", 5) == nil ]] and self.tgFrameInterval % 16 == 0 ) then
		self.tgFrame = self.tgFrame + 1
		self.tgFrameInterval = 0
	end
	
	if self.tgFrame > #entityFrames then
		self.tgFrame = 1
	end
	
	-- if (thing is jumping) and (frame is not a jumping frame) then (change the frame to a jumping one)
	if (self.tgVerticals < 0) and (string.find(entityFrames[self.tgFrame], "Jump") == nil) then
		frameChange = "Jump1"
	elseif (self.tgVerticals > 0) and (string.find(entityFrames[self.tgFrame], "Fall") == nil) then
		frameChange = "Fall1"
	elseif (self.tgVerticals == 0) then
		if (self.tgSpeed < 0) and (string.find(entityFrames[self.tgFrame], "WalkLeft") == nil) then
			frameChange = "WalkLeft1"
		elseif(self.tgSpeed > 0) and (string.find(entityFrames[self.tgFrame], "WalkRight") == nil) then
			frameChange = "WalkRight1"
		elseif(self.tgSpeed == 0) and (string.find(entityFrames[self.tgFrame], "Idle") == nil) then
			frameChange = "Idle1"
		end
	end
	
	if frameChange ~= "" then
		self.tgFrame = 1
		while entityFrames[self.tgFrame] ~= frameChange do
			self.tgFrame = self.tgFrame + 1
		end
	end
end

-- tile
function Player:plResolveCollision(pDirection)
	local col = self.tgColliding[pDirection]
	
	if things[col].tgType == "tile" then
		if direction[pDirection] == "left" then
			-- spawnParticle(self.tgHitbox.x, self.tgHitbox.y, 3, 1)
		elseif direction[pDirection] == "right" then
			-- spawnParticle(self.tgHitbox.x + self.tgHitbox.w, self.tgHitbox.y, 3, 1)
		end
	end
end

Tile = {tiIsSolid, tgSubtype}
Tile.__index = Tile

setmetatable(Tile, {
	__index = Thing,
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Tile:new(levelUnit, thingsUnit)
  --self.tgType = thingTypes["tile"]
  self.tgType = "tile"
  self.tgVerticals = 0
  self.tgSpeed = 0
  self.tgLevelUnit = levelUnit
  self.tgThingsUnit = thingsUnit
  self.tgFrame = 1
  self.tgFrameInterval = 0
  self.tgHealth = 100
  self.tgDashing = 0
  self.tgColliding = { -1, -1, -1, -1 }
  self.tiIsSolid = true
  self.tgSubtype = 1
  self.tgHitbox = Rectangle(0, 0, 0, 0)
  self.tgHitbox.w = DEFAULT_W
  self.tgHitbox.h = DEFAULT_H
  self.tgMaxFrames = graphicsIdentifiers[2][self.tgSubtype][2]
end

function Tile:tiHandleAI()
--[[
   if tileTypes[self.tgSubtype] == "DirtBlock" then
        -- instead of doing this, just include the things that actually need AI??
  elseif tileTypes[self.tgSubtype] == "DirtWall" then
        
  elseif tileTypes[self.tgSubtype] == "CloudBlock" then
	
  end
  ]]
end

function Tile:tiCycleFrames()
	if self.tgFrameInterval % 4 == 0 then
		self.tgFrame = self.tgFrame + 1
		self.tgFrameInterval = 0
	end
	if self.tgFrame > self.tgMaxFrames then
		self.tgFrame = 1
		self.tgFrameInterval = 0
	end
end

Enemy = {enPower, tgSubtype, enDashing}
Enemy.__index = Enemy

setmetatable(Enemy, {
	__index = Thing,
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Enemy:new(levelUnit, thingsUnit)
  --self.tgType = thingTypes["enemy"]
  self.tgType = "enemy"
  self.tgVerticals = 0
  self.tgDashing = 0
  self.tgSpeed = 0
  self.tgLevelUnit = levelUnit
  self.tgThingsUnit = thingsUnit
  self.tgFrame = 1
  self.tgFrameInterval = 0
  self.tgMaxFrames = #entityFrames
  self.tgColliding = { -1, -1, -1, -1 }
  self.tgHealth = -2
  self.tgDashing = 0
  self.enPower = -2
  self.tgSubtype = -1
  self.enDashing = 0
  self.enCooldown = 0
  self.tgHitbox = Rectangle(0, 0, 0, 0)
  self.tgHitbox.w = DEFAULT_ENEMY_W
  self.tgHitbox.h = DEFAULT_ENEMY_H
end

function Enemy:enHandleAI()
  local checkrect = Rectangle(0, 0, 0, 0)
  local iscolliding = false
  local t = enemyTypes[self.tgSubtype]
  
  if self.enCooldown > 0 then
	self.enCooldown = self.enCooldown - 1
  end
  
  if t == "Bean" then
	--if thingTypes[self.tgColliding] == "tile"
  
    if self.tgVerticals == 0 and self.tgDashing == 0 and self.enCooldown == 0 then
      --checkrect = self.tgHitbox
      checkrect.w = self.tgHitbox.w + DEFAULT_W * 4
      checkrect.x = self.tgHitbox.x - DEFAULT_W * 2
      checkrect.h = self.tgHitbox.h + DEFAULT_H * 4
      checkrect.y = self.tgHitbox.y - DEFAULT_H * 2
      iscolliding = checkCollision(checkrect, things[gPlayerUnit].tgHitbox)
      if iscolliding == true then
		--checkrect = self.tgHitbox
		checkrect.y = self.tgHitbox.y - DEFAULT_H
		if self.tgSpeed > 0 then
			checkrect.x = checkrect.x + dashArray[self.tgDashing + 1]
		elseif self.tgSpeed < 0 then
			checkrect.x = checkrect.x - dashArray[self.tgDashing + 1]
		end
		if checkCollision(checkrect, nil) == false then
			self.tgHitbox.y = self.tgHitbox.y - DEFAULT_H
			self.tgDashing = self.tgDashing + 1
		end
      end
	end
    if self.tgDashing ~= 0 then
	  -- self.tgVerticals = self.tgVerticals + 1
	  if self.enCooldown == 0 then
		self.enCooldown = DEFAULT_COOLDOWN
	  end
      if self.tgDashing < #dashArray then
        if self.tgSpeed > 0 then
          self.tgHitbox.x = self.tgHitbox.x + dashArray[self.tgDashing]
        elseif self.tgSpeed < 0 then
          self.tgHitbox.x = self.tgHitbox.x - dashArray[self.tgDashing]
        end
		self.tgDashing = self.tgDashing + 1
      else
        self.tgDashing = 0
      end
    end
	if self.tgSpeed == 0 then
		self.tgSpeed = DEFAULT_SPEED
	end
	if self.tgSpeed > 0 and self.tgSpeed ~= DEFAULT_SPEED then
		self.tgSpeed = DEFAULT_SPEED
	end
	if self.tgSpeed < 0 and self.tgSpeed ~= -DEFAULT_SPEED then
		self.tgSpeed = -DEFAULT_SPEED
	end
	--self.tgHitbox.x = self.tgHitbox.x + self.tgSpeed
	
	--[[
	self.tgHitbox.x = self.tgHitbox.x + self.tgSpeed
	for i = 1, #things do
		if things[i] ~= -1 and things[i].tgLevelUnit ~= self.tgLevelUnit then
			iscolliding = checkCollision(self.tgHitbox, things[i].tgHitbox)
			if iscolliding == true then
				if thingTypes[things[i].tgType] == "enemy" or thingTypes[things[i].tgType] == "tile" then
					self.tgSpeed = -self.tgSpeed
				elseif thingTypes[things[i].tgType] == "player" then
					
				end
			end
		end
	end
	]]
  elseif t == "Daub" then
	if self.tgSpeed == 0 then
		self.tgSpeed = DEFAULT_SPEED / 2
	end
	if self.tgSpeed > 0 and self.tgSpeed ~= DEFAULT_SPEED / 2 then
		self.tgSpeed = DEFAULT_SPEED / 2
	end
	if self.tgSpeed < 0 and self.tgSpeed ~= -DEFAULT_SPEED / 2 then
		self.tgSpeed = -DEFAULT_SPEED / 2
	end
	if self.enCooldown <= 0 then
		if self.tgSpeed > 0 then
			spawnProjectile(self.tgHitbox.x + self.tgHitbox.w, self.tgHitbox.y, 1, self.tgType, "right")
		elseif self.tgSpeed < 0 then
			spawnProjectile(self.tgHitbox.x, self.tgHitbox.y, 1, self.tgType, "left")
		end
		self.enCooldown = DEFAULT_COOLDOWN
	end
  elseif t == "Cragore" then
	if self.tgSpeed == 0 then
		self.tgSpeed = DEFAULT_SPEED
	end
	if self.tgSpeed > 0 and self.tgSpeed ~= DEFAULT_SPEED then
		self.tgSpeed = DEFAULT_SPEED
	end
	if self.tgSpeed < 0 and self.tgSpeed ~= -DEFAULT_SPEED then
		self.tgSpeed = -DEFAULT_SPEED
	end
	if self.enCooldown <= 0 then
		if self.tgSpeed > 0 then
			spawnProjectile(self.tgHitbox.x + self.tgHitbox.w, self.tgHitbox.y, 3, self.tgType, "right")
		elseif self.tgSpeed < 0 then
			spawnProjectile(self.tgHitbox.x, self.tgHitbox.y, 3, self.tgType, "left")
		end
		self.enCooldown = DEFAULT_COOLDOWN / 4
	end
  end
end

-- player, tile
function Enemy:enResolveCollision(pDirection)
	local t = enemyTypes[self.tgSubtype]
	local col = self.tgColliding[pDirection]

	if t == "Bean" or t == "Daub" or t == "Cragore" then
		if things[col].tgType == "player" then
			if direction[pDirection] == "down" then
				self.tgHealth = self.tgHealth - things[gPlayerUnit].plPower
				if things[gPlayerUnit].tgVerticals > 0 then
					things[gPlayerUnit].tgHitbox.y = things[gPlayerUnit].tgHitbox.y - gravityArray[things[gPlayerUnit].tgVerticals]
				end
				things[gPlayerUnit].tgVerticals = -1
			else -- if things[self.tgColliding[4]].tgType ~= "player" then
				things[gPlayerUnit].tgHealth = things[gPlayerUnit].tgHealth - self.enPower
				playAudio(SFX_INDEX, "Hurt")
			end
		end
		if things[col].tgType == "tile" then
		
		end
	--elseif t == "Daub" then
		
	end
	if self.tgHealth <= 0 then
		enDie(self.tgThingsUnit)
	end
end

function Enemy:enCycleFrames()
	local frameChange = ""
	self.tgFrameInterval = self.tgFrameInterval + 1
	-- if (speed ~= 0 and 4 frames have passed) or (frame == Idle1 and 64 frames have passed) or (thing is idle but is not on the first or last idle frame and 16 frames have passed) then (increment the frame and reset the frame counter)
	if ((self.tgSpeed ~= 0 or self.tgVerticals ~= 0) and self.tgFrameInterval % 4 == 0) or 
	(entityFrames[self.tgFrame] == "Idle1" and self.tgFrameInterval % 64 == 0) or
	(string.sub(entityFrames[self.tgFrame], 1, 4) == "Idle" and string.find(entityFrames[self.tgFrame], "1", 5) == nil --[[ and string.find(entityFrames[self.tgFrame], "4", 5) == nil ]] and self.tgFrameInterval % 16 == 0 ) then
		self.tgFrame = self.tgFrame + 1
		self.tgFrameInterval = 0
	end
	
	if self.tgFrame > #entityFrames then
		self.tgFrame = 1
	end
	
	-- if (thing is jumping) and (frame is not a jumping frame) then (change the frame to a jumping one)
	if (self.tgVerticals < 0) and (string.find(entityFrames[self.tgFrame], "Jump") == nil) then
		frameChange = "Jump1"
	elseif (self.tgVerticals > 0) and (string.find(entityFrames[self.tgFrame], "Fall") == nil) then
		frameChange = "Fall1"
	elseif (self.tgVerticals == 0) then
		if (self.tgSpeed < 0) and (string.find(entityFrames[self.tgFrame], "WalkLeft") == nil) then
			frameChange = "WalkLeft1"
		elseif(self.tgSpeed > 0) and (string.find(entityFrames[self.tgFrame], "WalkRight") == nil) then
			frameChange = "WalkRight1"
		elseif(self.tgSpeed == 0) and (string.find(entityFrames[self.tgFrame], "Idle") == nil) then
			frameChange = "Idle1"
		end
	end
	
	if frameChange ~= "" then
		self.tgFrame = 1
		while entityFrames[self.tgFrame] ~= frameChange do
			self.tgFrame = self.tgFrame + 1
		end
	end

	--[[
	local frameChange = ""
	local id = ""
	self.tgFrameInterval = self.tgFrameInterval + 1
	-- if (speed ~= 0 and 4 frames have passed) or (frame == Idle1 and 64 frames have passed) or (thing is idle but is not on the first or last idle frame and 16 frames have passed) then (increment the frame and reset the frame counter)
	if (self.tgSpeed ~= 0 and self.tgFrameInterval % 4 == 0) or 
	(entityFrames[self.tgFrame] == "Idle1" and self.tgFrameInterval % 64 == 0) or
	(string.sub(entityFrames[self.tgFrame], 1, 4) == "Idle" and string.find(entityFrames[self.tgFrame], "1", 5) == nil and string.find(entityFrames[self.tgFrame], "4", 5) == nil and self.tgFrameInterval % 16 == 0 ) then
		self.tgFrame = self.tgFrame + 1
		self.tgFrameInterval = 0
	end
	-- if (thing is jumping) and (frame is not a jumping frame) then (change the frame to a jumping one)
	if (self.tgVerticals < 0) and (string.find(entityFrames[self.tgFrame], "Jump") == nil) then
		frameChange = "Jump1"
	elseif (self.tgVerticals > 0) and (string.find(entityFrames[self.tgFrame], "Fall") == nil) then
		frameChange = "Fall1"
	elseif (self.tgSpeed < 0) and (string.find(entityFrames[self.tgFrame], "WalkLeft") == nil) then
		frameChange = "WalkLeft1"
	elseif(self.tgSpeed > 0) and (string.find(entityFrames[self.tgFrame], "WalkRight") == nil) then
		frameChange = "WalkRight1"
	elseif(self.tgSpeed == 0) and (string.find(entityFrames[self.tgFrame], "Idle") == nil) then
		frameChange = "Idle1"
	end
	if frameChange ~= "" then
		self.tgFrame = 1
		while entityFrames[self.tgFrame] ~= frameChange do
			self.tgFrame = self.tgFrame + 1
		end
	end
	for i = 1, (#entityFrames[self.tgFrame] - 1) do
		id = id .. (entityFrames[self.tgFrame])[i]
	end
	]]
	
	--for i = 1, #entityFrames do
	--	if (entityFrames[i] ~= nil or string.find(entityFrames[self.tgFrame + i], id) == nil) then
	--		self.tgMaxFrames = (entityFrames[self.tgFrame + (i - 1)])[#entityFrames[self.tgFrame + (i - 1)]]
	--		i = #entityFrames + 1
	--	end
	--end
	
	-- if self.tgFrame > self.tgMaxFrames then
	--	self.tgFrame = 1
	--	self.tgFrameInterval = 0
	-- end
end

function enDie(which)
	playAudio(SFX_INDEX, "Explosion")
	spawnParticle(things[which].tgHitbox.x, things[which].tgHitbox.y, 1, math.random(4, 8))
	spawnParticle(things[which].tgHitbox.x, things[which].tgHitbox.y, 4, math.random(0, 2))
	points = points + things[which].enPower
end

Collectible = {tgSubtype}
Collectible.__index = Collectible

setmetatable(Collectible, {
	__index = Thing,
	__call = function(pClass, ...)
		local self = setmetatable({}, pClass)
		self:new(...)
		return self
	end
})

function Collectible:new(levelUnit, thingsUnit)
  self.tgType = "collectible"
  self.tgVerticals = 0
  self.tgSpeed = 0
  self.tgLevelUnit = levelUnit
  self.tgThingsUnit = thingsUnit
  self.tgFrame = 1
  self.tgFrameInterval = 0
  self.tgHealth = 100
  self.tgDashing = 0
  self.tgColliding = { -1, -1, -1, -1 }
  self.tgSubtype = -1
  self.tgHitbox = Rectangle(0, 0, 0, 0)
  self.tgHitbox.w = DEFAULT_COLLECTIBLE_W
  self.tgHitbox.h = DEFAULT_COLLECTIBLE_H
end

function Collectible:clHandleAI()
	self.tgVerticals = self.tgVerticals + 1
	if self.tgVerticals > #floatArray then
		self.tgVerticals = 1
	end
	self.tgHitbox.y = self.tgHitbox.y + floatArray[self.tgVerticals]
end

function Collectible:clCollect()
    if collectibleTypes[self.tgSubtype] == "Bit" then
      points = points + 1
    elseif collectibleTypes[self.tgSubtype] == "Byte" then
      points = points + 8
	elseif collectibleTypes[self.tgSubtype] == "Jumpbit" then
	  points = points + 1
	  things[gPlayerUnit].plActionFrames = things[gPlayerUnit].plActionFrames + 1
	elseif collectibleTypes[self.tgSubtype] == "Strikebit" then
	  points = points + 1
	  things[gPlayerUnit].plPower = things[gPlayerUnit].plPower + 1
    end
	
	playAudio(SFX_INDEX, "Collect")
end

function Collectible:clCycleFrames()
	self.tgFrameInterval = self.tgFrameInterval + 1
	if self.tgFrameInterval >= 4 then
		self.tgFrame = self.tgFrame + 1
		self.tgFrameInterval = 0
	end
	if self.tgFrame >= #objectFrames then
		self.tgFrame = 1
	end
end

totalThings = #things
gBackground = Background()
gPlayerUnit = 0
gParticles = {}
totalParticles = #gParticles
gProjectiles = {}
totalProjectiles = #gProjectiles

-- converts a rectangular point to a polar point (with theta expressed in DEGREES)
function rectToPolar(rcoord)
	pcoord = PolarPoint(math.sqrt(rcoord.x * rcoord.x, rcoord.y * rcoord.y), math.atan(rcoord.y / rcoord.x) * 180 / math.pi)
	return pcoord
end

-- converts a polar point (with theta in DEGREES) to a rectangular point
function polarToRect(pcoord)
	rcoord = Point(pcoord.r * math.cos(pcoord.angle * math.pi / 180), pcoord.r * math.sin(pcoord.angle * math.pi / 180))
	return rcoord
end

function copythings(v)
  things[#things + 1] = v
end

function initFrames()
	local i = 1
	for j = 1, #frameIdentifiers[1] do
		for k = 1, frameIdentifiers[1][j][2] do
			entityFrames[i] = frameIdentifiers[1][j][1] .. k
			i = i + 1
		end
	end
	i = 1
	for j = 1, #frameIdentifiers[2] do
		for k = 1, frameIdentifiers[2][j][2] do
			objectFrames[i] = --[[ frameIdentifiers[2][j][1] .. ]] k
			i = i + 1
		end
	end
	
	--[[
	for i = 1, #frameIdentifiers[1] do
		for j = 1, frameIdentifiers[1][i][2] do
			entityFrames[i][j] = frameIdentifiers[1][i][1] .. j
		end
	end
	for i = 1, #frameIdentifiers[2] do
		for j = 1, frameIdentifiers[2][i][2] do
			objectFrames[i][j] = j
		end
	end
	]]
end

function init()
  math.randomseed(os.time())
  initFrames()
  for i = 1, #things do
    if things[i] ~= -1 then
      if thingTypes[things[i][1]] == "player" then
        things[i] = Player(things[i][2], i)
		gPlayerUnit = i
      elseif thingTypes[things[i][1]] == "tile" then
        things[i] = Tile(things[i][2], i)
      elseif thingTypes[things[i][1]] == "enemy" then
        things[i] = Enemy(things[i][2], i)
      elseif thingTypes[things[i][1]] == "collectible" then
        things[i] = Collectible(things[i][2], i)
      --else
        --things[i] = nil
      end
	  
	  if things[i] ~= -1 then
		local lx, ly, amt = things[i].tgLevelUnit, things[i].tgLevelUnit, 0
		while lx >= LEVEL_W do
			lx = lx - LEVEL_W
			amt = amt + 1
		end
		things[i].tgHitbox.x = lx * DEFAULT_W
		things[i].tgHitbox.y = amt * DEFAULT_H
	  end
   --else
		--things[i] = nil
	end
  end
end

function initThings()
	for i = 1, #things do
		if things[i] ~= -1 then
			if things[i].tgType == "collectible" then
				if collectibleTypes[things[i].tgSubtype] == "Bit" then
					things[i].tgHitbox.w = DEFAULT_COLLECTIBLE_W / 2
					things[i].tgHitbox.h = DEFAULT_COLLECTIBLE_H / 2
				end
			elseif things[i].tgType == "enemy" then
				if enemyTypes[things[i].tgSubtype] == "Cragore" then
					things[i].tgHitbox.w = DEFAULT_ENEMY_W * 2
					things[i].tgHitbox.h = DEFAULT_ENEMY_H * 2
				end
			end
		end
	end
end

function handleEnvironment()
	totalThings = #things
	totalParticles = #gParticles
	totalProjectiles = #gProjectiles
	
	for i = 1, #gParticles do
		if gParticles[i] ~= nil then
			gParticles[i]:ptCycleFrames()
		end
	end
	for i = 1, #gProjectiles do
		if gProjectiles[i] ~= nil then
			gProjectiles[i]:pjCycleFrames()
			gProjectiles[i]:pjMove()
		end
	end
	for i = 1, #things do
		if things[i] ~= -1 then
			if things[i].tgType == "player" then
				things[i]:plCycleFrames()
				
				for j = 1, #things[i].tgColliding do
					if things[i].tgColliding[j] ~= -1 then
						things[i]:plResolveCollision(j)
					end
				end
				
				if things[i].tgVerticals == -2 then
					playAudio(SFX_INDEX, "Jump")
				end
				if things[i].tgDashing == 3 or things[i].tgDashing == -3 then
					playAudio(SFX_INDEX, "Dash")
				end
				
			elseif things[i].tgType == "tile" then
				things[i]:tiCycleFrames()
				things[i]:tiHandleAI()
				
			elseif things[i].tgType == "enemy" then
				if things[i].tgHealth == -2 or things[i].enPower == -2 then
					things[i].tgHealth = enemyStats[things[i].tgSubtype][HEALTH_INDEX]
					things[i].enPower = enemyStats[things[i].tgSubtype][POWER_INDEX]
				end
				
				things[i]:enCycleFrames()
				things[i]:enHandleAI()
				for j = 1, #things[i].tgColliding do
					if things[i].tgColliding[j] ~= -1 then
						things[i]:enResolveCollision(j)
					end
				end
				--[[
				if things[gPlayerUnit].tgColliding ~= -1 and things[gPlayerUnit].tgColDir ~= -1 then
				print(things[gPlayerUnit].tgColliding)
					if thingTypes[things[things[gPlayerUnit].tgColliding].tgType] == "enemy" then
						things[i].tgColDir = invertDir(things[gPlayerUnit].tgColDir)
						things[i]:enResolveCollision()
					end
				end
				]]
				
			elseif things[i].tgType == "collectible" then
				things[i]:clCycleFrames()
				things[i]:clHandleAI()
				if things[i].tgHealth == 0 then
					things[i]:clCollect()
				end
				
			end
		end
	end
end

function invertDir(dir)
	if direction[dir] == "up" then
		dir = 1
		while direction[dir] ~= "down" do
			dir = dir + 1
		end
	elseif direction[dir] == "down" then
		dir = 1
		while direction[dir] ~= "up" do
			dir = dir + 1
		end
	elseif direction[dir] == "left" then
		dir = 1
		while direction[dir] ~= "right" do
			dir = dir + 1
		end
	elseif direction[dir] == "right" then
		dir = 1
		while direction[dir] ~= "left" do
			dir = dir + 1
		end
	end
end

function playAudio(pType, pName)
	local i = 1
	while audioBuffer[pType][i] ~= nil do
		i = i + 1
	end
	audioBuffer[pType][i] = pName
end

function incGFXscale()
	WINDOW_W = WINDOW_W * GFX_MULT
	WINDOW_H = WINDOW_H * GFX_MULT
	DEFAULT_W = DEFAULT_W * GFX_MULT
	DEFAULT_H = DEFAULT_H * GFX_MULT
	PLAYER_W = PLAYER_W * GFX_MULT
	PLAYER_H = PLAYER_H * GFX_MULT
	DEFAULT_ENEMY_W = DEFAULT_ENEMY_W * GFX_MULT
	DEFAULT_ENEMY_H = DEFAULT_ENEMY_H * GFX_MULT
	DEFAULT_COLLECTIBLE_W = DEFAULT_COLLECTIBLE_W * GFX_MULT
	DEFAULT_COLLECTIBLE_H = DEFAULT_COLLECTIBLE_H * GFX_MULT
	DEFAULT_PARTICLE_W = DEFAULT_PARTICLE_W * GFX_MULT
	DEFAULT_PARTICLE_H = DEFAULT_PARTICLE_H * GFX_MULT
	DEFAULT_PROJECTILE_W = DEFAULT_PROJECTILE_W * GFX_MULT
	DEFAULT_PROJECTILE_H = DEFAULT_PROJECTILE_H * GFX_MULT
	DEFAULT_GFX_OFFSET = DEFAULT_GFX_OFFSET * GFX_MULT
	DEFAULT_SPEED = DEFAULT_SPEED * GFX_MULT
	for i = 1, #gParticles do
		if gParticles[i] ~= nil then
			gParticles[i].ptRect.x = gParticles[i].ptRect.x * GFX_MULT
			gParticles[i].ptRect.y = gParticles[i].ptRect.y * GFX_MULT
			gParticles[i].ptRect.w = gParticles[i].ptRect.w * GFX_MULT
			gParticles[i].ptRect.h = gParticles[i].ptRect.h * GFX_MULT
		end
	end
	for i = 1, #gProjectiles do
		if gProjectiles[i] ~= nil then
			gProjectiles[i].pjRect.x = gProjectiles[i].pjRect.x * GFX_MULT
			gProjectiles[i].pjRect.y = gProjectiles[i].pjRect.y * GFX_MULT
			gProjectiles[i].pjRect.w = gProjectiles[i].pjRect.w * GFX_MULT
			gProjectiles[i].pjRect.h = gProjectiles[i].pjRect.h * GFX_MULT
		end
	end
	for i = 1, #jumpArray do
		jumpArray[i] = jumpArray[i] * GFX_MULT
	end
	for i = 1, #gravityArray do
		gravityArray[i] = gravityArray[i] * GFX_MULT
	end
	for i = 1, #dashArray do
		dashArray[i] = dashArray[i] * GFX_MULT
	end
	for i = 1, #floatArray do
		floatArray[i] = floatArray[i] * GFX_MULT
	end
	--[[
	for i = 1, #things do
		if things[i] ~= -1 then
			things[i].tgHitbox.x = things[i].tgHitbox.x * GFX_MULT
			things[i].tgHitbox.y = things[i].tgHitbox.y * GFX_MULT
			things[i].tgHitbox.w = things[i].tgHitbox.w * GFX_MULT
			things[i].tgHitbox.h = things[i].tgHitbox.h * GFX_MULT
		end
	end]]
	-- everything else should be handled in c++
end

function spawnParticle(px, py, ptype, pnum)
	local num = pnum
	local i = 1
	while num > 0 do
		if gParticles[i] == nil then
			gParticles[i] = Particle(ptype, px, py)
			num = num - 1
		end
		i = i + 1
	end
end

function deleteParticle(which)
	-- gParticles[which] = nil
	table.remove(gParticles, which)
end

function spawnProjectile(px, py, ptype, pwhat, pdirection)
	local i = 1
	while true do
		if gProjectiles[i] == nil then
			gProjectiles[i] = Projectile(ptype, px, py, pwhat, pdirection)
			return
		end
		i = i + 1
	end
end

function deleteProjectile(which)
	--if which > #gProjectiles then
	--	gProjectiles[which] = nil
	if which <= #gProjectiles then
		table.remove(gProjectiles, which)
	end
end

function updateDeletedThings()
	local i = 1
	while i <= #things do
		if things[i] == -1 then
			table.remove(things, i)
			i = i - 1
		elseif things[i] ~= nil then
			things[i].tgThingsUnit = i
		end
		i = i + 1
	end
end

function closeLevel()
	things = {}
end

--[[
function checkCollision(thing1, thing2)
	if thing2 == nil then
		for i = 0, #things do
			if things[i] ~= -1 then
				if (thing1.x + thing1.w > things[i].tgHitbox.x or thing1.x < things[i].tgHitbox.x + things[i].tgHitbox.w) and 
					(thins1.y + thing1.h > things[i].tgHitbox.y or thing1.y < things[i].tgHitbox.y + things[i].tgHitbox.h) then
					
				end
			end
		end
	end
end
]]

--[[
function init()
  local j = -1
  for i = 1, #things, 1 do
    if things[i] ~= -1 then
      if things[i] == thingTypes["player"] then

        things[i] = Player:new(i)
      elseif things[i] == thingTypes["tile"] then
        things[i] = Tile:new(i)
      elseif things[i] == thingTypes["enemy"] then
        things[i] = Enemy:new(i)
      elseif things[i] == thingTypes["collectible"] then
        things[i] = Collectible:new(i)
      else
        things[i] = nil
      end
    else
		things[i] = nil
	end
  end
end
]]

--[[
function initIdentifiers()
	dir = "resources/"
	ext = ".png"
	
	for i = 1, #tileTypes do
		table.insert(graphicsIdentifiers, tiles[i], (dir .. tileTypes[i] .. ext))
	end
end
]]

--[[
function handleEnvironment()
  for i = 1, #things do
    if things[i].tgType == thingTypes[enemy]then
      things[i].enHandleAI()
    elseif things[i].tgType == thingTypes[tile] then
      things[i].tiHandleAI()
    end
  
  end
  
end
]]

--[[
function handleLevelLoad(levelUnits)
	for i = 1, levelUnits + 1, 1 do
		--if things[i] == nil then
		things[i] = -1

		--end
	end
end
]]

--[[
function Thing:tgHandleVerticals()
  if tgVerticals >= #gravityArray then
      tgVerticals = #gravityArray - 2
    elseif (-tgVerticals >= #jumpArray) then
      tgVerticals = 0
    end

    if (tgVerticals < 0) then
      tgHitbox.y = tgHitbox.y - jumpArray[-(tgVerticals)]
      tgVerticals = tgVerticals - 1
    elseif (tgVerticals > 0) then
      tgHitbox.y = tgHitbox.y + jumpArray[tgVerticals]
      tgVerticals = tgVerticals + 1
    end
      
      return tgVerticals
  end
]]



--[[
function Player:tgHandleVerticals()
    	if tgVerticals >= #gravityArray then
      tgVerticals = #gravityArray - 2
    elseif (-tgVerticals >= #jumpArray) then
      tgVerticals = 0
    end

    if (tgVerticals < 0) then
      tgVerticals = tgVerticals - 1
    elseif (tgVerticals > 0) then
      tgVerticals = tgVerticals + 1
    end
      
      
      
      return tgVerticals
  end

  function Player:plMove()
	--Direction dir = NO_DIRECTION;
	colliding = checkCollision(true, gPlayer.tgHitbox)
	nextMove = self.tgHitbox
	moveX = 0, moveY = 0
	left = false, right = false, up = false, down = false

	if (tgVerticals == 0 && plOldVerticals != 0) then
		self:tgHandleVerticals()
		self:plHandleDashing()
		plOldVerticals = tgVerticals
		plOldHitboxRect = tgHitbox
	else
		plOldVerticals = tgVerticals
		plOldHitboxRect = tgHitbox
		self:tgHandleVerticals()
		self:plHandleDashing()
	end

	if (tgSpeed != 0) then
		nextMove = self.tgHitboxRect
		moveX = moveX + self.tgSpeed
		nextMove.x = nextMove.x + tgSpeed;
		if (checkCollision(true, nextMove)) then  
			moveX -= (tgSpeed < 0 ? -1 : 1);
			nextMove.tgHitboxRect.x -= (tgSpeed < 0 ? -1 : 1);
			while (Game::checkCollision(&nextMove, NULL, tgLevelUnit, false))
			{
				moveX -= (tgSpeed < 0 ? -1 : 1);
				nextMove.tgHitboxRect.x -= (tgSpeed < 0 ? -1 : 1);
			}
			if (tgSpeed > 0)
				right = true;
			else if (tgSpeed < 0)
				left = true;
			tgSpeed = 0;
		}
		tgHitboxRect.x += moveX;
	}
	if (tgVerticals != 0)
	{
		nextMove.tgHitboxRect = tgHitboxRect;
		moveY += (tgVerticals < 0 ? -Game::jumpArray[-tgVerticals] : Game::gravityArray[tgVerticals]);
		nextMove.tgHitboxRect.y += (tgVerticals < 0 ? -Game::jumpArray[-tgVerticals] : Game::gravityArray[tgVerticals]);
		if (Game::checkCollision(&nextMove, NULL, tgLevelUnit, false))
		{
			moveY -= (tgVerticals < 0 ? -1 : 1);
			nextMove.tgHitboxRect.y -= (tgVerticals < 0 ? -1 : 1);
			while (Game::checkCollision(&nextMove, NULL, tgLevelUnit, false))
			{
				moveY -= (tgVerticals < 0 ? -1 : 1);
				nextMove.tgHitboxRect.y -= (tgVerticals < 0 ? -1 : 1);
			}
			if (tgVerticals < 0)
				up = true;
			else if (tgVerticals > 0)
			{
				plJumps = 0;
				down = true;
			}
			tgVerticals = 0;
		}
		tgHitboxRect.y += moveY;
		// if (moveY == (tgVerticals < 0 ? -Game::jumpArray[-tgVerticals] : Game::gravityArray[tgVerticals]))
	}
	if (tgVerticals == 0)
	{
		nextMove.tgHitboxRect = tgHitboxRect;
		nextMove.tgHitboxRect.y++;
		if (!Game::checkCollision(&nextMove, NULL, tgLevelUnit, false))
			tgVerticals++;
	}

	Game::checkCollision(Game::things[tgLevelUnit], NULL, tgLevelUnit, true);
	for (int i = 0; i < Level::LEVEL_UNITS; i++)
	{
		if (Game::gColliding[i] != NULL)
		{
			if (up)
			{
				up = false;
				dir = UP;
			}
			else if (left)
			{
				left = false;
				dir = LEFT;
			}
			else if (right)
			{
				right = false;
				dir = RIGHT;
			}
			else if (down)
			{
				down = false;
				dir = DOWN;
			}
			Game::gColliding[i]->thing2->tgResolveCollision(Game::things[tgLevelUnit], dir);
		}
	}
}
]]

--[[
vertFuncs = { 
  function plHandleVerticals(plVerticals)
  	if plVerticals >= #gravityArray then
      plVerticals = #gravityArray - 2
    elseif (-plVerticals >= #jumpArray) then
      plVerticals = 0
    end

    if (plVerticals < 0) then
      plVerticals = plVerticals - 1
    elseif (plVerticals > 0) then
      plVerticals = plVerticals + 1
    end
      
      
      
      return plVerticals
  end,

  function tgHandleVerticals(tgVerticals, tgRect)
  	if tgVerticals >= #gravityArray then
      tgVerticals = #gravityArray - 2
    elseif (-tgVerticals >= #jumpArray) then
      tgVerticals = 0
    end

    if (tgVerticals < 0) then
      tgRect.y = tgRect.y - jumpArray[-(tgVerticals)]
      tgVerticals = tgVerticals - 1
    elseif (tgVerticals > 0) then
      tgRect.y = tgRect.y + jumpArray[tgVerticals]
      tgVerticals = tgVerticals + 1
    end
      
      return tgVerticals
  end
}
]]