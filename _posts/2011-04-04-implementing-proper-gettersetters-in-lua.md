---
layout: post
title: Implementing Proper Getter/Setters in Lua
category: Tutorials
tags:
  - Lua
  - MiddleClass
  - OOP
  - programming
---

When I create a class in Lua, there are always times when I need to use a getter or setter on attributes, instead of raw access. The way I've always done this is to use methods with names like `getFoo` and `setFoo`. And then to keep my API consistent, I have to switch every single property to use these getter/setter methods. The pain about these type of methods is that:

* You have to switch everything, even attributes that don't need getter and setters, to keep your API consistent. This would end up slowing everything down.
* It doesn't look as proper as using real getting and setting syntax, like `obj.foo` and `obj.foo = v`.
* It's more to type.

What I really wanted was syntax like this:

{% highlight lua %}
obj.attr
obj.attr = something
{% endhighlight %}

I originally thought that implementing this would make things even slower, but that's actually not the case. So let's get started.

## Implementation

{% highlight lua %}
Test = class('Test')

function Test:initialize()
  self.foo = 3
end

function Test:getFoo()
  return self.foo
end

function Test:setFoo(v)
  self.foo = v
end
{% endhighlight %}

Here we have a small little [MiddleClass](http://github.com/kikito/middleclass) class, which has a getter and setter method for the attribute `foo`. Let's see how we can improve its API.

{% highlight lua %}
Test = class('Test')

local mt = {}

mt.__index = function(self, key) 
  if self._props[key] ~= nil then
    return self._props[key]
  else
    return Test.__classDict[key]
  end
end

mt.__newindex = function(self, key, value)
  if self._props[key] ~= nil then
    self._props[key] = value
  else
    rawset(self, key, value)
  end
end

function Test:initialize()
  self._props = { foo = 3 }
  local old = getmetatable(self)
  old.__index = mt.__index
  old.__newindex = mt.__newindex
end
{% endhighlight %}

I'll admit, this code doesn't look as nice (this could be wrapped into a mixin to make it look better), but the API results are awesome. What we're doing here, it created a metatable with the `__index` and `__newindex` methods. For those who don't know what these metamethods do, I suggest you go [read about them](http://www.lua.org/pil/13.html) in the [Programming in Lua](http://www.lua.org/pil/) book.

Once we get inside of `__index` we can trigger getter code. In this case I'm only looking in `self._props`, but what you could do is check for a certain key name, and then run the proper getter code for it. But remember, you must also offer a way to get inside the `__classDict` attribute of the class, as this is where all instance methods are stored.

**EDIT:** To support inheritance change `ClassName.__classDict` to `self.class.__classDict`. I found this out the hard way.

The same thing goes for `__newindex`. We could check the key, and then trigger setting code; but in this case we're just setting stuff in `_props`. We also fall back to just setting something on the instance itself; if we didn't do this, we would cripple the ability to set anything other than the pre-initialised properties (maybe this is what you want; the sky is the limit).

Right, after all that this allows us to do this:

{% highlight lua %}
local t = Test:new()
print(t.foo) -- 3
t.foo = 4
print(t.foo) -- 4
{% endhighlight %}

## Speed Tests

Now let's have a look at the speed. We'll use this class for all the tests:

{% highlight lua %}
Test = class('Test')

local mt = {}

mt.__index = function(self, key) 
  if self._props[key] ~= nil then
    return self._props[key]
  else
    return Test.__classDict[key]
  end
end

mt.__newindex = function(self, key, value)
  if self._props[key] ~= nil then
    self._props[key] = value
  else
    rawset(self, key, value)
  end
end

function Test:initialize()
  self._props = { foo = 3 }
  setmetatable(self, mt)
end

function Test:getFoo()
  return self._props.foo
end

function Test:setFoo(v)
  self._props.foo = v
end

local t = Test()
{% endhighlight %}

(If you're wondering why I'm not using `getmetatable` and then setting its properties, this is because this is the original code I was working with, and therefore run the tests. Soon after I noticed that using `setmetatable` would destroy any other metatable before it, so I changed my code. However I couldn't be bothered to re-run the tests &ndash; the results should be the same, but for test integrity I haven't modified the code.)

### The Original Way

We'll test getting with this code:

{% highlight lua %}
for i = 1, 1000000 do
  local a = t:getFoo() -- we'll need this assignment for the other tests later
end
{% endhighlight %}

It loops a million times, calling `getFoo`. First my machine's stats:

{% highlight lua %}
MacBook 2,1 - Mac OS X 10.6.6
2 Ghz Intel Core 2 Duo
2 GB DDR2 memory

Lua 5.1.4
{% endhighlight %}

And now the results of running `time lua test.lua`:

{% highlight lua %}
real	0m0.577s
user	0m0.423s
sys	0m0.004s
{% endhighlight %}

Now for setting:

{% highlight lua %}
for i = 1, 1000000 do
  t:setFoo(4)
end
{% endhighlight %}

Result:

{% highlight lua %}
real	0m0.535s
user	0m0.420s
sys	0m0.012s
{% endhighlight %}

### The Awesome Way

For getting:

{% highlight lua %}
for i = 1, 1000000 do
  -- this is where we need that assignment
  -- lua won't accept just the code 't.foo'
  local a = t.foo
end
{% endhighlight %}

Result:

{% highlight lua %}
real	0m0.295s
user	0m0.267s
sys	0m0.005s
{% endhighlight %}

For setting:

{% highlight lua %}
for i = 1, 1000000 do
  t.foo = 4
end
{% endhighlight %}

Result:

{% highlight lua %}
real	0m0.323s
user	0m0.251s
sys	0m0.004s
{% endhighlight %}

## Conclusion

So as you can see, not only does this method create a much nicer API (unless you love using get* and set* methods), but also _improves_ speed quite a lot, which I didn't expect. And take into consideration, that not only does this improve speed a lot on the front of getter and setter methods, but also allows you to leave to properties that don't need getters and setters, just as plain properties; this will improve speed even more. So it's a win both ways.

Enjoy!

**EDIT:** In the comments, Josh has noted that the reason why `t:getFoo()` is slower is because it's going through the same metatable as `t.foo`, invoking a `rawget` call. Without this, `t:getFoo()` is actually a little faster.
