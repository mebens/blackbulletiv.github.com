---
layout: post
title: "How It Works: The Thruster in Facilitated Escape"
date: 2011-10-23 14:06:00
category: Tutorials
tags:
  - How It Works
  - programming
  - game development
  - Lua
  - Love2D
  - Facilitated Escape
---

In this post I'll be taking a look at how I programmed aspects of the ship's thruster in my game, [Facilitated Escape](/games/facilitated-escape). I'll most likely be making more posts like this in the future (as in, I intend to make a series of "How It Works" posts).

Initially I had a lot of trouble getting the thruster to look right; you might be able to see some of my troubles in the [Ludum Dare time-lapse](http://www.youtube.com/watch?v=1mFjpDqBEPE). The reason for this was that I had programmed the game to move the ship on the y axis instead of moving everything else, as expressed by this code (line [72 of ship.lua](https://github.com/BlackBulletIV/facilitated-escape/blob/master/modules/ship.lua#L72))

{% highlight lua %}
ship.y = ship.y - ship.ySpeed * dt
{% endhighlight %}

I originally tried programming the particle system to shoot out particles in the opposite direction of the ship, which is what happens in reality. Unfortunately, since the ship is moving so fast, this ended up producing a number of clusters of particles lined up behind the ship. I suspect these represented each frame of the game where the movement of the particles were updated.

I eventually worked out that I needed to reverse the direction of the particle system. I'm still not exactly sure why this worked, but I'll give you my theory. The particles are emitted and the ship leaves them behind (because of its speed). However, since they are moving towards the ship, some of the particles cover the gaps that appeared previously. Anyway, this is the code for setting up the particle system:

{% highlight lua %}
ps = love.graphics.newParticleSystem(particle, 1000)
ps:setParticleLife(0.2, 0.5)
ps:setSize(1, 3)
ps:setDirection(-math.tau / 4)
ps:setSpread(math.tau / 24)
ps:setColor(152, 41, 14, 150, 142, 38, 13, 0)
ship.fire = ps
{% endhighlight %}

And from the `ship.reset` function:

{% highlight lua %}
ship.fireSpeed = 75
ship.fireRate = 250
ship.fire:setSpeed(ship.fireSpeed - 50, ship.fireSpeed + 50)
ship.fire:setEmissionRate(ship.fireRate)
ship.fire:start()
{% endhighlight %}

One thing to note is that you have to adjust the speed of the particle system according to the speed of the ship. This is due to the fact the particles are being sent out in reverse. Here's most of the code involved in that (from `ship.update`):

{% highlight lua %}
if ship.ySpeed < 650 then
  ship.ySpeed = math.min(ship.ySpeed + ship.yIncrease * dt, 650)
  ship.fireSpeed = ship.fireSpeed + ship.yIncrease / 3 * dt
  ship.fireRate = ship.fireRate + ship.yIncrease / 1.5 * dt
  ship.fire:setEmissionRate(ship.fireRate)
end

ship.y = ship.y - ship.ySpeed * dt
ship.distance = math.abs(ship.y - ship.initialY)
ship.fire:setSpeed(ship.fireSpeed - 50, ship.fireSpeed + 50)
{% endhighlight %}

One final thing I'd like to mention is how the fire is drawn. To make it look more like real fire, I changed the blend mode used to draw the particle system to "additive". I think that additive blending results in colours being added together according to their alpha value, rather than the normal way of combining non-opaque colours. All I had to do was lessen the alpha of the particle system's colour, and draw it like this:

{% highlight lua %}
love.graphics.setBlendMode("additive")
love.graphics.draw(ship.fire)
love.graphics.setBlendMode("alpha")
{% endhighlight %}

Resulting in the nice fire effect you see in the game.

Anyway, thanks for reading; I hope that wasn't too confusing. Remember you can find the [full code](https://github.com/BlackBulletIV/facilitated-escape/blob/master/modules/ship.lua) for the ship over at the game's [GitHub repo](https://github.com/BlackBulletIV/facilitated-escape).