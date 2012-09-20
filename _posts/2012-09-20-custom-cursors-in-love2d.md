---

layout: post
title: "Custom Cursors in Love2D"
date: 2012-09-20 21:27:54
category: Tutorials
tags:
  - Lua
  - programming
  - Love2D
  - game development

---

When making a game in Love2D, you'll probably end up needing to customise the mouse cursor. As I recently had to do just that, I thought I'd make a quick tutorial on it. If you want an example cursor, here's the [crosshair](/images/posts/crosshair.png) I'm using in a game right now.

Now, all of what we need is contained within the [`love.mouse`](https://love2d.org/wiki/love.mouse) module. The first step is to hide the mouse with [`love.mouse.setVisible`](https://love2d.org/wiki/love.mouse.setVisible). You'll probably want to do this in [`love.load`](https://love2d.org/wiki/love.load):

{% highlight lua %}
function love.load()
  love.mouse.setVisible(false)
  love.mouse.setGrab(true)
end
{% endhighlight %}

It's probably a good idea to confine the mouse cursor to the window via [`love.mouse.setGrab`](https://love2d.org/wiki/love.mouse.setGrab), as we have here.

Now all you need to do is draw an image at the position of the mouse every frame:

{% highlight lua %}
function love.draw()
  love.graphics.draw(cursorImage, love.mouse.getX(), love.mouse.getY())
end
{% endhighlight %}

So, for a complete example:

{% highlight lua %}
function love.load()
  cursor = love.graphics.newImage("crosshair.png")
  love.mouse.setVisible(false)
  love.mouse.setGrab(true)
end

function love.draw()
  love.graphics.draw(cursor, love.mouse.getX() - cursor:getWidth() / 2, love.mouse.getY() - cursor:getHeight() / 2)
end
{% endhighlight %}

You might be wondering why I've subtracted half the image's width/height from the coordinates. In this case it's because when using something like a crosshair, the centre, not the top left, of the cursor image should indicate the exact point where the mouse is.

Well, that's it for now. I hope this tutorial's been useful to you.
