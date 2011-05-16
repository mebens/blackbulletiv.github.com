---
layout: post
title: "Cameras in Love2D Part 2: Parallax Scrolling"
category: Tutorials
tags:
  - display programming
  - game development
  - Love2D
  - Lua
  - programming
---

In [part 1](/2011/04/19/cameras-in-love2d-part-1-the-basics) we constructed a basic camera. Now we're going to extend it by adding some parallax scrolling. Note that the method I'll use is probably not the prettiest, as I came up with it in half an hour. Nevertheless, this will be a starting point for you to develop your own system.

## What Is It?

Now, for those who don't know, what is parallax scrolling? It's a way to get a pseudo-3D effect while still have all graphics and gameplay based in 2D. It's currently used very widely among 2D games, as it adds a sense of depth that normally isn't there.

The technique we'll use to achieve this is called the [layer method](http://en.wikipedia.org/wiki/Parallax_scrolling#The_layer_method). What we need to do is render many layers of graphics, which are affected (move) at different rates when the camera moves. Normally the playing field (where the player is, and all the action happens) will be affected at a 1:1 ratio. Layers "closer" to the camera than the playing field will move at a faster rate than the camera. Layers "farther" from the camera than the playing field will move at a slower rate than the camera.

## Implementation

Alright, enough talk, now onto implementation. To implement this, we'll use a rough layering system which is managed by the camera. Here's the modifications to the original `camera` module we made. First add this to the top, after setting the other values like `x` and `y`.

{% highlight lua %}
camera.layers = {}
{% endhighlight %}

The will, obviously, hold our layers. Next add this method:

{% highlight lua %}
function camera:newLayer(scale, func)
  table.insert(self.layers, { draw = func, scale = scale })
  table.sort(self.layers, function(a, b) return a.scale < b.scale end)
end
{% endhighlight %}

This is how we'll create new layers. `scale` is what the camera's x and y position are multiplied by before drawing the layer. `func` is a function which will draw the objects on that layer. We then have to sort the layers table by their scale, so ones with a lower scale will be drawn first; as in, the further away the layer, the earlier is will be drawn.

Next add this method:

{% highlight lua %}
function camera:draw()
  local bx, by = self.x, self.y
  
  for _, v in ipairs(self.layers) do
    self.x = bx * v.scale
    self.y = by * v.scale
    camera:set()
    v.draw()
    camera:unset()
  end
end
{% endhighlight %}

The function takes care of drawing all the layers. `bx` and `by` are the "base" x/y position, as in the original position of the camera. Before calling `camera:set` and the drawing function, we multiply the camera's position by the layer's scale. We then do the usual drawing steps. 

So will all this in place, our `love.draw` definition will become:

{% highlight lua %}
function love.draw()
  camera:draw()
end
{% endhighlight %}

## A Quick Example

I made a quick example to show off the parallax system. Here's the code for it:

{% highlight lua %}
require('camera')

math.randomseed(os.time())
math.random()
math.random()
math.random()

function love.load(args)
  camera.layers = {}
  
  for i = .5, 3, .5 do
    local rectangles = {}
    
    for j = 1, math.random(2, 15) do
      table.insert(rectangles, {
        math.random(0, 1600),
        math.random(0, 1600),
        math.random(50, 400),
        math.random(50, 400),
        color = { math.random(0, 255), math.random(0, 255), math.random(0, 255) }
      })
    end
    
    camera:newLayer(i, function()
      for _, v in ipairs(rectangles) do
        love.graphics.setColor(v.color)
        love.graphics.rectangle('fill', unpack(v))
        love.graphics.setColor(255, 255, 255)
      end
    end)
  end
end

function love.update(dt)
  camera:setPosition(love.mouse.getX() * 2, love.mouse.getY() * 2)
end

function love.draw()
  camera:draw()
  love.graphics.print("FPS: " .. love.timer.getFPS(), 2, 2)
end

function love.keypressed(key, unicode)
  if key == ' ' then
    love.load()
  elseif key == 'escape' then
    love.event.push('q')
  end
end
{% endhighlight %}

What this does is it creates 6 layers, starting at a scale of .5, going up to 3. The `rectangles` table stores the information for a random number of rectangles to be drawn on the current layer. We don't need a global because, the only function using this table is created inside the current local scope. The function for each layer simply draws the information contained each rectangle's table.

You can reset everything by pressing space. This calls `love.load`, and this is the reason why we re-create the `camera.layers` table. You can quit by pressing escape.

One final thing to note is that up the top we're calling `math.random` three times, because it has been reported that the first three or so times you call `math.random` it's not a very random number. I don't think I've ever experienced this myself, but it can't hurt to throw in a few calls just in case.

## Conclusion

Well that coves a basic parallax scrolling implementation. From here you can go on to create something a bit more beautiful in design for your own projects. If you've got any thoughts or suggestions, I'd greatly appreciate it if you could leave them in the comments.

Thanks for reading!

**[&raquo; Part 3](/2011/05/09/cameras-in-love2d-part-3-movement-bounds)**

