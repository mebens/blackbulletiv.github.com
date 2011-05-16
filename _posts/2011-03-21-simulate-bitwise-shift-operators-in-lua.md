---
layout: post
title: Simulate Bitwise Shift Operators in Lua
category: Tutorials
tags:
  - bitwise
  - Lua
  - maths
  - programming
---

**EDIT:** Here's a couple functions which will do the shift operations that I've put in gist #938502.

The fact that Lua doesn't have bitwise operators is a pain. There are pure Lua implementations out there, such as [LuaBit](http://luaforge.net/projects/bit/), but I find these to be a little slow (I think LuaBit using tables or something like that). I've found a way to simulate both the left-shift and right-shift operator by using some simple mathematics. 

## Left-Shift

By my analysis of how the left-shift operator works, for every shift, it multiplies the number by the specified power of two. It's hard to put into words, show let me show you:

{% highlight c %}
// even
20 << 1 == 40
20 << 2 == 80
20 << 3 == 160
// ...

// odd
21 << 1 == 42
21 << 2 == 84
// ...
{% endhighlight %}

Therefore, it occurred to me that I could just multiply by a power of two to get the same result. See this Lua code:

{% highlight lua %}
-- even
20 * 2 ^ 1 == 40
20 * 2 ^ 2 == 80
20 * 2 ^ 3 == 160

-- odd
21 * 2 ^ 1 == 42
21 * 2 ^ 2 == 84
{% endhighlight %}

The way I've used this is to convert separate RGB values into a 24 bit color:

{% highlight lua %}
r * 2 ^ 16 + b * 2 ^ 8 + g
{% endhighlight %}

Whereas the normal way to do this in a language with bitwise operators would be:

{% highlight lua %}
r << 16 | b << 8 | g
{% endhighlight %}

You might be wondering how I replaced the bitwise or with addition. Well, because we're shifting these numbers up a byte at a time, no 1s will overlap (these numbers are 0-255 of course), therefore making addition equivalent to a bitwise or.

## Right-Shift

I tried to reverse the solution of left-shift by dividing; that works, but only to a certain extent. When a 1 in the binary string is shifted off, it is lost. But by dividing, we get stuff like .5 instead of losing the data. The obvious way to fix this is math.floor:

{% highlight lua %}
math.floor(20 / 2 ^ 1) == 10
math.floor(20 / 2 ^ 3) == 2
{% endhighlight %}

And traditional code would be:

{% highlight c %}
20 >> 1 == 10
20 >> 3 == 2
{% endhighlight %}

What we could do is extract the individual RGB components of a color. This is how we could extract the red from a 24 bit color:

{% highlight lua %}
math.floor(color / 2 ^ 16)
{% endhighlight %}

However, to get the blue or green values we would (normally) need the bitwise and operator, which I can't figure out how to implement. But there is a workaround:

{% highlight lua %}
math.floor(color / 2 ^ 8) % 2 ^ 8 -- green
color % 2 ^ 8 -- blue
{% endhighlight %}

I was shown by "[bartbes](https://bitbucket.org/bartbes)", that by using the modulos operator we can limit the number to a certain amount of bits (8 in this case).

Enjoy!
