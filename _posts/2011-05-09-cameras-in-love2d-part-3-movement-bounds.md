---
layout: post
title: "Cameras in Love2D Part 3: Movement Bounds"
category: Tutorials
tags:
  - display programming
  - game development
  - Love2D
  - Lua
  - programming
---

Because there was some interest in a part 3, of this series, I've written it, and in this part we'll cover creating bounds that the camera can't move beyond. Make sure you've read [part 1](/2011/04/19/cameras-in-love2d-part-1-the-basics) and [part 2](/2011/04/22/cameras-in-love2d-part-2-parallax-scrolling) before continuing.

In case you're wondering what I mean by this, I mean restricting the movement of the camera to a "box", as in, having minimum and maximum x/y coordinates for the camera. This comes in handy when you're following players, for example, and you don't want the camera to show any of the stuff beyond the level (usually blackness) when the player comes to an edge. Now of course, movement bounding can get much more complicated than a simple rectangle, you restrict it to certain paths and the like, but we're going to keep it simple here.

## Implementation

We're going to achieve this by clamping the x/y coordinates of the camera to the minimum and maximum x/y values given (the bounds). We'll do this using a handy little clamping function, which I've named `math.clamp`:

{% highlight lua %}
function math.clamp(x, min, max)
  return x < min and min or (x > max and max or x)
end
{% endhighlight %}

That's a very compact version however, you may want to use this version for more clarity, if you're still getting to grips with some of the subtleties of Lua:

{% highlight lua %}
function math.clamp(x, min, max)
  if x < min then
    return min
  elseif x > max then
    return max
  else
    return x
  end
end
{% endhighlight %}

With that out of the way, we need to find a way to restrict the x/y values. We could do this only when they're changed, by using a setter, or we could clamp them every single frame inside of `camera:set`. The latter way is much less efficient, so I'm going with the former. Because the new module is rather large, I've put the code in a Gist; click the link and take a look at `camera.lua` to get it. Take note that `math.clamp` needs to be defined somewhere.

**[Camera Module Code](https://gist.github.com/961685#file_camera.lua)**

Here's what has changed from part 1's `camera` module:

* x/y values are now stored in `camera._x`/`camera._y` instead of `camera.x`/`camera.y`. Reference to those variables in the `camera` module's methods have been changed accordingly.
* We now use `setX`/`setY` to set the x/y positions.
* `setPosition` now just calls `setX` and `setY`.
* `getBounds`/`setBounds` has been added.

Now, I would much rather be using my [metatable approach](/2011/04/04/implementing-proper-gettersetters-in-lua) to setters, but that would needlessly complicate things; you can convert the `camera` to that if you want.

Anyway, how is this working? Well, `setX` and `setY` check if there is `camera._bounds` exists, and if so, they use the respective values to make sure the x/y position of the camera never exceeds the maximum values provided. We can setup the bounds using `setBounds`, which will create the `camera._bounds` table.

## An Example

With that out of the way, I'm going to give you a quick example of how this might be used. In the same Gist I've put `main.lua` which contains the example code.

**[Example Code](https://gist.github.com/961685#file_main.lua)**

`love.load` sets up tables for the player, the bounding walls (which is just box), and some random white boxes (used to see that you're moving). It's pretty obvious what `love.update` is doing, allowing movement of the player via the arrow keys and making the camera centre on the player. `love.draw` is just drawing the information contained in the tables.

Now for the important part. In `love.load` we call `setBounds` passing in a minimum x/y position of 0, 0, and a maximum of the width and height of the screen. 0, 0 comes from the x/y position of the box, but where does `width`, `height` come from? Well the bottom-right corner of the box is `width * 2`, `height * 2`. We only want the camera to as far as the bottom-right corner, and since the camera's "width" and "height" is equal to the width and height of the screen, the maximum x/y position is equal to `width * 2 - width`, `height * 2 - height`, or `boxWidth - cameraWidth`, `boxHeight - cameraHeight`, which of course equals, `width`, `height`.

## Conclusion

Well, that's all folks. I hope you've learnt something, and thanks for reading. If you've got any thoughts/comments/suggestions, please leave them in the [comments section](#respond). Also remember the camera module and example code is a available at gist #961685.
