---
layout: post
title: Draw Origins in Love2D
category: Tutorials
tags:
  - display programming
  - game development
  - Love2D
  - Lua
  - programming
---

In this post I'm going to be showing you origins when drawing stuff in [Love2D](http://love2d.org). First of all, what are origins? They specify the offset for the origin of the object's x/y coordinates. In other words, if you specify the x origin to be 20, the object will be drawn 20 pixels to the left, as in x - 20. It's the same for the y origin: if we have a y origin of 20, the object will be drawn 20 pixels up, as in y - 20.

This allows us to do many useful things. First of all, if we have an object with centre based coordinates (like physical bodies), instead of drawing like this:

{% highlight lua %}
love.graphics.draw(img, self.x - self.width / 2, self.y - self.height / 2)
{% endhighlight %}

we can now do it like this:

{% highlight lua %}
love.graphics.draw(img, self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
{% endhighlight %}

The last two parameters here are the origin x and y, respectively (`0, 1, 1` is rotation, scale x, and scale y, respectively). This doesn't give us anything better, but you know what else this allows us to do? Origin x/y also specifies the point around which this object will be rotated. Normally if we specified a rotation, the object would be drawn rotating around the top-left corner, which in most cases is ugly. But if we specify the origin to be at the centre, the object will also rotate around the centre.

This really comes in handy with the shapes in love.physics, as they will certainly rotate:

{% highlight lua %}
love.graphics.draw(img, self.x, self.y, self.rotation, 1, 1, self.width / 2, self.height / 2)
{% endhighlight %}

But of course, we don't just have to use origins for centering objects. If you have an object with coordinates starting at different corners of the object, you could use one of these lines:

{% highlight lua %}
love.graphics.draw(img, self.x, self.y, self.rotation, 1, 1, self.width) -- top right
love.graphics.draw(img, self.x, self.y, self.rotation, 1, 1, self.width, self.height) -- bottom right
love.graphics.draw(img, self.x, self.y, self.rotation, 1, 1, 0, self.height) -- bottom left
{% endhighlight %}

Thanks for reading, and I hope you learnt something. If you've got any thoughts, or you'd like to see something in particular, please leave in the [comments](#respond) below.

