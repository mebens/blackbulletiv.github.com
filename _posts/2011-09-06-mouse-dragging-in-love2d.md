---
layout: post
title: Mouse Dragging in Love2D
date: 2011-09-06 10:02:03
category: Tutorials
tags:
  - programming
  - game development
  - Lua
  - Love2D
---

In this tutorial, I'll be taking you through my method of enabling objects to dragged by the mouse (in LÖVE of course). You can view the completed code for this tutorial at gist #1196228.

So, say you have an object with x/y coordinates, width, and height, and you want this object to be draggable by the mouse. For this tutorial, I'm just going to construct a table and put in the global, `rect`:

{% highlight lua %}
function love.load()
  rect = {
    x = 100,
    y = 100,
    width = 100,
    height = 100,
    dragging = { active = false, diffX = 0, diffY = 0 }
  }
end
{% endhighlight %}

The next thing we need to do is define `love.draw` to draw the rectangle. (We'll see what `rect.dragging` is all about soon.)

{% highlight lua %}
function love.draw()
  love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
end
{% endhighlight %}

Now here's where the good stuff begins:

{% highlight lua %}
function love.mousepressed(x, y, button)
  if button == "l"
  and x > rect.x and x < rect.x + rect.width
  and y > rect.y and y < rect.y + rect.height
  then
    rect.dragging.active = true
    rect.dragging.diffX = x - rect.x
    rect.dragging.diffY = y - rect.y
  end
end
{% endhighlight %}

The `if` statement checks for whether the left mouse button was pressed, and does a simple collision check to see if the mouse button was pressed while inside the bounds of the rectangle. If so, we update the variables inside `rect.dragging`.

`rect.dragging` is where we store persistent information about the current dragging action.  `active` is used to tell whether a dragging action is taking place at all. The other two, `diffX` and `diffY`, are used to store the difference between the top-left corner of the rectangle and the mouse's position when the mouse button was initially clicked. To find out why these variables are important, we need to define `love.update`:

{% highlight lua %}
function love.update(dt)
  if rect.dragging.active then
    rect.x = love.mouse.getX() - rect.dragging.diffX
    rect.y = love.mouse.getY() - rect.dragging.diffY
  end
end
{% endhighlight %}

If the mouse is currently dragging, we update the rectangle's x/y coordinates. Instead of just setting the rectangles coordinates to the mouse's respective coordinates, we subtract `diffX` and `diffY`, respectively. Why is this? If we were to not do this, the rectangle's top-left corner would jump to the mouse's position whenever the rectangle is dragged, and that doesn't look good at all. Subtracting the initial difference in positions will fix this problem.

Finally, to make sure that dragging is turned off properly:

{% highlight lua %}
function love.mousereleased(x, y, button)
  if button == "l" then rect.dragging.active = false end
end
{% endhighlight %}

And that's it. As stated, you can view the complete code at gist #1196228. Of course, this code is just one implementation of the method I use; you will most likely implement it differently depending on what you use it for.

Anyway, thanks for reading!