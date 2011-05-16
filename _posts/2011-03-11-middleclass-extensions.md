---
layout: post
title: MiddleClass Extensions
category: Projects
tags:
  - Lua
  - MiddleClass
  - OOP
  - programming
---

I've just recently opened up a new repository at GitHub called [middleclass-extensions](http://github.com/BlackBulletIV/middleclass-extensions), which contains my personal hacks, extensions, extras, whatever you want to call them, to MiddleClass. It's a bit like [middleclass-extras](http://github.com/kikito/middleclass-extras). So far the repo only contains one extensions, called Static, but this will grow over time.

Static is about creating class only methods. When you create a method which you intend to be accessed only via the class, MiddleClass has no way to distinguish them, so you end up having all methods accessible through instances and classes. What Static allows you to do is stop certain methods from being including in instances, and make them only accessible via the class. Let's see:

{% highlight lua %}
require 'middleclass-extensions.Static'

Foo = class('Foo'):include(Static)

function Foo:something() print("Hello world!") end
function Foo:classOnly() print("Hello class!") end
function Foo:classOnlyAgain() print("Hello class! (again)") end

Foo:static('classOnly', 'classOnlyAgain')

f = Foo()
f:something() -- "Hello world!"
Foo:classOnly() -- "Hello class!"
Foo:classOnlyAgain() -- "Hello class! (again)"
f:classOnly() -- No method!
{% endhighlight %}

Static adds the static function to your class, which receives the names of the methods you want to be class only.

Enjoy!

