---
layout: post
title: "Singleton Class in MiddleClass (Lua)"
category: Tutorials
tags:
  - Lua
  - MiddleClass
  - OOP
  - programming
---

I thought I'd demonstrate a method for making a singleton class in [MiddleClass](http://github.com/kikito/middleclass). If you don't know, MiddleClass is an object-orientation library for [Lua](http://lua.org).

So why would you want to make a class that only has one instance with MiddleClass? Couldn't you just use a table? Well, making it a class in MiddleClass allows you to take advantage of a number of other cool things that MiddleClass has on offer, like mixins, inheritance and so on. So let's have a look at the method.

Create a new file for our class, something like Singleton.lua. Place this code in it:

{% highlight lua %}
require 'middleclass.init'

local SingletonClass = class('Singleton')
Singleton = SingletonClass()

function SingletonClass:initialize()
    print('Hello singleton!')
end
{% endhighlight %}

You can probably see what's going on. What we're doing, is creating a class definition that is inaccessible to the outside program (via the use of 'local'). This is what we will use to declare all the methods of the class. We make this singleton available by creating an instance of our class and assigning it to a variable with the name we want our singleton to be referenced by.

Another finishing step you could take is to add a __tostring method:

{% highlight lua %}
function SingletonClass:__tostring()
    print('Singleton module') -- or 'instance of singleton Singleton', or something like that
end
{% endhighlight %}

This is so it doesn't come up as 'instance of Singleton' when someone converts your singleton to a string.

Anyway, thanks for reading!
