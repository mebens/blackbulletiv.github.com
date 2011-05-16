---
layout: post
title: Specifying Names in Lua Without Strings
category: Tutorials
tags:
  - Lua
  - OOP
  - programming
---

Lua is the most flexible language I've ever used, aside from its speed, this is probably the best thing about it. In this post, I'm going to show you how to specify names of things in function arguments, without strings. The method I'll use it a bit hackish, and isn't fit for normal operation; but hey, Lua allows us do it!

For an example, say you had an OOP implementation that used a function called `class` like this:

{% highlight lua %}
class('MyClass')
{% endhighlight %}

What we're going to change that into, is this:

{% highlight lua %}
class(MyClass)
{% endhighlight %}

## Finding When `class` is Called

Lua stores all globals in a table called _G, which itself is a global (`_G._G._G == _G`). We'll make use of this by using a metatable with an __index function on _G:

{% highlight lua %}
local _called

setmetatable(_G, {
  __index = function(_, key)
    if key == 'class' then
      _called = true
      return _class
    elseif _called then
      _called = false
      return key
    else
      return rawget(_G, key)
    end
  end
})
{% endhighlight %}

What's happening here? If the caller asks for a function called `class` we'll set a variable called _called to true. This lets us know that `class` has been indexed. We then use this in the elseif statement and if it's true we'll return the key, which is a string of the name used; we also set _called to false. Finally, we revert to using `rawget` with _G and the key.

There's one catch with this approach. If the user doesn't actually call `class`, but instead passes it as an argument or something, bad things will happen. The next time they index something that isn't there, they'll get a string of the name used, which will most likely stuff their code up. This is what I mean by "hackish".

## The _class function

We've renamed the class function to _class, otherwise __index wouldn't get called. This is because __index is only called if the requested name doesn't exist in the table. For demonstration purposes, we'll just print out the name given:

{% highlight lua %}
function _class(name, otherStuff)
  print(name)
  -- normally hardcore OOP stuff would go here...
end
{% endhighlight %}

When you call:

{% highlight lua %}
class(FooBar)
{% endhighlight %}

"FooBar" should be printed out. Ah the flexibility of Lua! Thanks for reading!

