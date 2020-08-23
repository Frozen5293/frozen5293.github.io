---
title: anime of charactor
layout: page
tags: ProgramDesign
categories: ProgramDesign
date: 2020-08-04 13:03
---
## _LUA_

``` lua
Use a Quad to display part of an Image:
img = love.graphics.newImage("mushroom-64x64.png")
 
-- Let's say we want to display only the top-left 
-- 32x32 quadrant of the Image:
top_left = love.graphics.newQuad(0, 0, 32, 32, img:getDimensions())
 
-- And here is bottom left:
bottom_left = love.graphics.newQuad(0, 32, 32, 32, img:getDimensions())
 
function love.draw()
	love.graphics.draw(img, top_left, 50, 50)
	love.graphics.draw(img, bottom_left, 50, 200)
	-- v0.8:
	-- love.graphics.drawq(img, top_left, 50, 50)
	-- love.graphics.drawq(img, bottom_left, 50, 200)
end
---------------------------------------------------
from：https://love2d.org/wiki/love.graphics.newQuad
---------------------------------------------------
``` 
> 浅显易懂

``` lua
-------------------------------------------------
-- Available since LÖVE 11.0
-- This variant is not supported in earlier versions.
-------------------------------------------------
    love.graphics.draw( texture, quad, transform )

-----------------------------------------------------
-- Available since LÖVE 0.9.0
-- It has replaced love.graphics.drawq.
-----------------------------------------------------
love.graphics.draw( texture, quad, x, y, r, sx, sy, ox, oy, kx, ky )

--Texture texture
    A Texture (Image or Canvas) to texture the Quad with.
```
> 具体的关于函数的解释



 sky
 lost
 for(
 stand1
 stand2
 )
 run 
 block
 attacked
 attack
 attackp

