---
layout: post
title: "Cameras in Love2D Part 1: The Basics"
category: Tutorials
tags:
  - display programming
  - game development
  - Love2D
  - Lua
  - programming
---

This is the first of a couple of blogs on creating cameras in the [L&#214;VE engine](http://love2d.org). This part will deal with the fundamentals of creating a camera. [Part two](/2011/04/22/cameras-in-love2d-part-2-parallax-scrolling) will deal with parallax scrolling and creating layers. So, let's get to it!

**Update**: I've actually ended up writing a [part 3](/2011/05/09/cameras-in-love2d-part-3-movement-bounds), which covers restricting camera movement.

## The Functions

The functions we'll need are these:

* [love.graphics.pop](http://love2d.org/wiki/love.graphics.pop)
* [love.graphics.push](http://love2d.org/wiki/love.graphics.push)
* [love.graphics.translate](http://love2d.org/wiki/love.graphics.translate)
* [love.graphics.rotate](http://love2d.org/wiki/love.graphics.rotate)
* [love.graphics.scale](http://love2d.org/wiki/love.graphics.scale)

Love2D (I'll use this name from now on, as it's easier to type) has a transformation stack, as in a stack of separate collections of transformation information. `love.graphics.push` allows us to push the current transformation upwards in the stack, and insert a new transformation under it, so to speak. `love.graphics.pop` discards the current transformation and sets the current transformation to whatever was before the old one in the stack. Let's see some ASCII art:

    Starting:
    |-----------|
    | Default   |
    |-----------|

    love.graphics.push:
    |-----------|
    | Default   |       ^ pushed up
    |-----------|
    |-----------|
    | New       |       <- pushed under
    |-----------|

    love.graphics.pop:
    |-----------|         |-----------|
    | Default   |         | New       |  -> discarded
    |-----------|         |-----------|

Now, `translate`, `scale`, and `rotate` modify the information in the current transformation. The x and y parameters given to `translate` are added to _every_ x and y coordinate used to draw to the screen. Every x and y coordinate is multiplied by the values given to `scale`. Finally, every position (an x/y vector) given is rotated by the value given to `rotate`, with the top-left corner of the screen as the rotation centre.

With that description, you could construct the most minimal camera like this:

{% highlight lua %}
function love.draw()
  love.graphics.translate(-x, -y)
  -- draw
end
{% endhighlight %}

Here `translate` is operating on the default transformation. The transformation stack is reset every frame, so we must apply our changes every frame. For a more complete implementation of a camera we could do this:

{% highlight lua %}
function love.draw()
  love.graphics.rotate(-rotation) -- this is in radians
  love.graphics.scale(1 / zoom, 1 / zoom)
  love.graphics.translate(-x, -y)
end
{% endhighlight %}

`-rotation` and `-x, -y` makes it so that all positions are "left behind" if they don't move with the camera. The values passed to `scale` makes it so that zoom values less than 1 zoom the camera in, and values greater than 1 zoom the camera out.

## The `camera` Module

Let's organise this a bit to make the `camera` module. Here's the code for it:

{% highlight lua %}
camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0

function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end
{% endhighlight %}

The `camera` module is a table, that contains the information it needs to be positioned. The key functions here are `set` and `unset`. `set` applies the information in the `camera` module, and also creating a new transformation for it (to support multiple views in one frame). `unset` simply removes the latest transformation using `pop`. The rest of the functions are simply to aid in adjusting the properties of `camera`.

You can use this camera by putting this code in love.draw:

{% highlight lua %}
function love.draw()
  camera:set()
  -- draw stuff
  camera:unset()
end
{% endhighlight %}

Then in the update stage of things you can change the camera's position, zoom, or rotation.

{% highlight lua %}
camera.x = 50
camera:scale(3) -- zoom by 3
{% endhighlight %}

## The Mouse

Now, if you want to interact with the mouse inside the game world, you're going to need to adjust the coordinates returned by `love.mouse.getX/Y/Position()`. You can do this either by redefining those functions, or by adding some new functions to the `camera` module.

{% highlight lua %}
function camera:mousePosition()
  return love.mouse.getX() * self.scaleX + self.x, love.mouse.getY() * self.scaleY + self.y
end
{% endhighlight %}

That accounts for scaling and translation for the mouse coordinates. If you want to account for rotation, you'll need to do some vector rotation. See [HUMP's vector class](https://github.com/vrld/hump/blob/master/vector.lua#L127) for that.

## Conclusion

Well thanks for reading. I hope you learnt something, please tell me what you think in the comment box. See you in part two!

**[&raquo; Part Two](/2011/04/22/cameras-in-love2d-part-2-parallax-scrolling)**
