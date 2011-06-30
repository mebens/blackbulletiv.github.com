---
layout: post
title: Lua Metatables Tutorial
date: 2011-06-30 14:12:00
category: Tutorials
tags:
  - programming
  - Lua
  - OOP
---

In this tutorial I'll be covering a very important concept in [Lua](http://lua.org): metatables. Knowledge of how to use metatables will allow you to be much more powerful in your use of Lua. Every table can have a metatable attached to it. A metatable is a table which, with some certain keys set, can change the behaviour of the table it's attached to. Let's see an example.

{% highlight lua %}
t = {} -- our normal table
mt = {} -- our metatable, which contains nothing right now
setmetatable(t, mt) -- sets mt to be t's metatable
getmetatable(t) -- this will return mt
{% endhighlight %}

As you can see, [`getmetatable`](http://www.lua.org/manual/5.1/manual.html#pdf-getmetatable) and [`setmetatable`](http://www.lua.org/manual/5.1/manual.html#pdf-setmetatable) are the main functions here; I think it's pretty obvious what they do. Of course, in this case we could contract the first three lines into this:

{% highlight lua %}
t = setmetatable({}, {})
{% endhighlight %}

`setmetatable` returns its first argument, therefore we can use this shorter form.

Now, what do we put in these metatables? Metatables can contain anything, but they respond to certain keys (which are strings of course) which start with `__`, such as `__index` and `__newindex`. The values corresponding to these keys will usually be functions or other tables. An example:

{% highlight lua %}
t = setmetatable({}, {
  __index = function(t, key)
    if key == "foo" then
      return 0
    else
      return table[key]
    end
  end
})
{% endhighlight %}

So as you can see, we assign a function to the `__index` key. Now let's have a look at what this key is all about.

## `__index`

The most used metatable key is most likely `__index`; it can contain either a function or table.

When you look up a table with a key, regardless of what the key is (`t[4]`, `t.foo`, and `t["foo"]`, for example), and a value hasn't been assigned for that key, Lua will look for an `__index` key in the table's metatable (if it has a metatable). If `__index` contains a table, Lua will look up the key originally used in the table belonging to `__index`. This probably sounds confusing, so here's an example:

{% highlight lua %}
other = { foo = 3 }
t = setmetatable({}, { __index = other })
t.foo -- 3
t.bar -- nil
{% endhighlight %}

If `__index` contains a function, then it's called, with the table that is being looked up and the key used as parameters. As we saw in the code example above the last one, this allows us to use conditionals on the key, and basically anything else that Lua code can do. Therefore, in that example, if the key was equal to the string "foo" we would return 0, otherwise we look up the `table` table with the key that was used; this makes `t` an alias of `table` that returns 0 when the key "foo" is used.

You may be wondering why the table is passed as a first parameter to the `__index` function. This comes in handy if you use the same metatable for multiple tables, supporting code re-use and saving computer resources. We'll see an example of this when we take a look at the `Vector` class.

## `__newindex`

Next in line is `__newindex`, which is similar to `__index`. Like `__index`, it can contain either a function or table.

When you try to set a value in a table that is not already present, Lua will look for a `__newindex` key in the metatable. It's the same sort of situation as `__index`; if `__newindex` is a table, the key and value will be set in the table specified:

{% highlight lua %}
other = {}
t = setmetatable({}, { __newindex = other })
t.foo = 3
other.foo -- 3
t.foo -- nil
{% endhighlight %}

As would be expected, if `__newindex` is a function, it will be called with the table, key, and value passed as parameters:

{% highlight lua %}
t = setmetatable({}, {
  __newindex = function(t, key, value)
    if type(value) == "number" then
      rawset(t, key, value * value)
    else
      rawset(t, key, value)
    end
  end
})

t.foo = "foo"
t.bar = 4
t.la = 10
t.foo -- "foo"
t.bar -- 16
t.la -- 100
{% endhighlight %}

When creating a new key in `t`, if the value is a number it will be squared, otherwise it will just be set anyway. This introduces us to our friends, `rawget` and `rawset`.

## `rawget` and `rawset`

There are times when you need get and set a table's keys without having Lua do it's thing with metatables. As you might guess, [`rawget`](http://www.lua.org/manual/5.1/manual.html#pdf-rawget) allows you to get the value of a key without Lua using `__index`, and [`rawset`](http://www.lua.org/manual/5.1/manual.html#pdf-rawset) allows you to set the value of a key without Lua using `__newindex` (no these don't provide a speed increase to conventional way of doing things). You'll need to use these when you would otherwise get stuck in an infinite loop. For example, in that last code example, the code `t[key] = value * value` would set off the same `__newindex` function again, which would get you stuck in an infinite loop. Using `rawset(t, key, value * value)` avoids this.

As you probably can see, to use these functions, for parameters we must pass in the target table, the key, and if you're using `rawset`, the value.

## Operators

Many of the metatable keys available have to do with operators (as in, `+`, `-`, etc.), allowing you to make tables support the use of operators on them. For example, say we wanted a table to support the multiplication operator (`*`), this is how we would do it:

{% highlight lua %}
t = setmetatable({ 1, 2, 3 }, {
  __mul = function(t, other)
    new = {}
    
    for i = 1, other do
      for _, v in ipairs(t) do table.insert(new, v) end
    end
    
    return new
  end
})

t = t * 2 -- { 1, 2, 3, 1, 2, 3 }
{% endhighlight %}

This allows us to create a new table with the original replicated a certain amount of times using the multiplication operator. As you can tell, the corresponding key for multiplication is `__mul`; unlike `__index` and `__newindex` the keys for operators can only contain functions. The first parameter these functions always receive is the target table, and then the value on the right hand side (except for the unary `-` which has the key of `__unm`). Here's a list of the supported operators:

* `__add`: Addition (`+`)
* `__sub`: Subtraction (`-`)
* `__mul`: Multiplication (`*`)
* `__div`: Division (`/`)
* `__mod`: Modulos (`%`)
* `__unm`: Unary `-`, used for negation on numbers
* `__concat`: Concatenation (`..`)
* `__eq`: Equality (`==`)
* `__lt`: Less than (`<`)
* `__le`: Less than or equal to (`<=`)

(There's only `==`, `<`, `<=` because you can implement full support for the comparison operators with just those; in fact only `==` and `<` are needed.)

## `__call`

Next comes the `__call` key, which allows you to call tables as functions. A code example:

{% highlight lua %}
t = setmetatable({}, {
  __call = function(t, a, b, c, whatever)
    return (a + b + c) * whatever
  end
})

t(1, 2, 3, 4) -- 24
{% endhighlight %}

The function in call is passed the target table as usual, followed by the parameters that we passed in.

`__call` is very useful for many things. One common thing it's used for is forwarding a call on a table to a function inside that table. An example is found in [kikito](https://github.com/kikito)'s [tween.lua](https://github.com/kikito/tween.lua/blob/master/tween.lua#L339) library, where `tween.start` can also be called by calling the table itself (`tween`). Another example is found in [MiddleClass](https://github.com/kikito/middleclass/blob/master/middleclass.lua#L64), where a classes' `new` method can be called by just calling the class itself.

## `__tostring`

Last of all is `__tostring`. If implemented, it's used by [`tostring`](http://www.lua.org/manual/5.1/manual.html#pdf-tostring) to convert a table into a string, most handy when using a function like [`print`](http://www.lua.org/manual/5.1/manual.html#pdf-print). Normally, when you try to convert a table to a string, you something in the format of "table: 0x&lt;hex-code-here&gt;", but you can change that using `__tostring`. An example:

{% highlight lua %}
t = setmetatable({ 1, 2, 3 }, {
  __tostring = function(t)
    sum = 0
    for _, v in pairs(t) do sum = sum + v end
    return "Sum: " .. sum
  end
})

print(t) -- prints out "Sum: 6"
{% endhighlight %}

## Building the Vector Class

To wrap everything up, we'll write a class encapsulating a 2D vector (thanks to [hump.vector](https://github.com/vrld/hump/blob/master/vector.lua) for much of the code). It's too large to put here, but you can see the full code at gist #1055480. I've positioned all the stuff to do with metatables first in the file, as that's the most important stuff. (Be warned, this may be a bit confusing if you've never encountered Object-Oriented Programming before.)

{% highlight lua %}
Vector = {}
Vector.__index = Vector
{% endhighlight %}

This code sets up the table for the `Vector` class, and sets the `__index` key to point back at itself. Now, what's going on here? You've probably noticed that we've put all the metatable methods inside the `Vector` class. What you're seeing is the simplest way to achieve OOP (Object-Oriented Programming) in Lua. The `Vector` table represents the class, which contains all the functions that instances can use. `Vector.new` (shown below) creates a new instance of this class.

{% highlight lua %}
function Vector.new(x, y)
  return setmetatable({ x = x or 0, y = y or 0 }, Vector)
end
{% endhighlight %}

It creates a new table with `x` and `y` properties, and then sets the metatable to the `Vector` class. As we know, `Vector` contains all the metamethods and especially the `__index` key. This means that we can use all the functions we define in `Vector` through this new table. We'll come back to this in a moment.

Another important thing is the last line:

{% highlight lua %}
setmetatable(Vector, { __call = function(_, ...) return Vector.new(...) end })
{% endhighlight %}

This means that we can create a new `Vector` instance by either calling `Vector.new` or just `Vector`.

The last important thing that you may not be aware of is the colon syntax. When we define a function with a colon, like this:

{% highlight lua %}
function t:method(a, b, c)
  -- ...
end
{% endhighlight %}

What we are really doing is defining this function:

{% highlight lua %}
function t.method(self, a, b, c)
  -- ...
end
{% endhighlight %}

This is syntactic sugar to help with OOP. We can then use the colon syntax when calling functions:

{% highlight lua %}
-- these are the same
t:method(1, 2, 3)
t.method(t, 1, 2, 3)
{% endhighlight %}

Now, how do we use this `Vector` class? Here's an example:

{% highlight lua %}
a = Vector.new(10, 10)
b = Vector(20, 11)
c = a + b
print(a:len()) -- 14.142135623731
print(a) -- (10, 10)
print(c) -- (30, 21)
print(a < c) -- true
print(a == b) -- false
{% endhighlight %}

Because of the `__index` in `Vector`, we can use all the methods defined in the class through the instances.

## Conclusion

Thanks for reading, I hope you've learned something. If you have any suggestions or comments, please leave them in the [comments section](#respond) below; I'd love to hear from you!
