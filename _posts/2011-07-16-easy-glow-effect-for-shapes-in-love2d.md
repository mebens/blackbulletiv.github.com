---
layout: post
title: Glow Effect for Lined Shapes in Love2D
date: 2011-07-16 18:58:03
category: Tutorials
tags:
  - programming
  - game development
  - Lua
  - Love2D
  - display programming
---

Recently I experimented with an easy way to make lined shapes glow (using [LÖVE](http://love2d.org) of course). There are of course other ways of doing it, and there are many styles of glow that can be used, but this is the one I came up with.

{% highlight lua %}
love.graphics.setColor(r, g, b, 15)

for i = 7, 2, -1 do
  if i == 2 then
    i = 1
    love.graphics.setColor(r, g, b, 255)
  end
  
  love.graphics.setLineWidth(i)
  -- draw lined shape here
end
{% endhighlight %}

The shape get drawn multiple times, each time with a different line width, set by `i`. In all, six shapes are drawn with the widths 7, 6, 5, 4, 3, 1. For all the lines, except the last, the alpha of the colour (by the way, `r`, `g`, and `b` represent the respective values of whatever colour you might choose) is set to 15. Since the alpha of every overlapping colour is added to each other (by default), for each line the colour will get stronger and stronger, giving the glow effect. The last line is given an alpha of 255, since this is where all the "light" is meant to be coming from.

Of course, these values have just come from my fiddling around, you'll probably want to tweak them yourself to get the effect you need.

I personally have generalised this code into a function:

{% highlight lua %}
function glowShape(r, g, b, type, ...)
  love.graphics.setColor(r, g, b, 15)
  
  for i = 7, 2, -1 do
    if i == 2 then
      i = 1
      love.graphics.setColor(r, g, b, 255)    
    end
    
    love.graphics.setLineWidth(i)
    
    if type == "line" then
      love.graphics[type](...)
    else
      love.graphics[type]("line", ...)
    end
  end
end
{% endhighlight %}

An example usage would be:

{% highlight lua %}
function love.draw()
  glowShape(255, 0, 0, "rectangle", 200, 100, 100, 100)
  glowShape(0, 255, 0, "polygon", 300, 300, 310, 330, 350, 290, 360, 310, 290, 350)
end
{% endhighlight %}

Which should look something like this:

![A couple of glowing shapes.](/images/posts/love2d_shape_glow.png)

A final thing you may want to do is check for framebuffer support on the current machine, and if they're supported, drawing the glowing shapes to a framebuffer. This should save a lot of performance, because drawing shapes is expensive, especially drawing many copies of them.

Anyway, thanks for reading! As always, please shout out in the comments if you've got any thoughts or suggestions.
