---
layout: post
title: Mixin Inheritance in MiddleClass
category: Tutorials
tags:
  - Lua
  - MiddleClass
  - OOP
  - programming
---

The technique I'm about to present, may seem obvious, but I'll share it anyway. The way I would create mixins that inherit stuff from other mixins is this:

{% highlight lua %}
Mixin = {}

function Mixin:included(class)
  if not includes(ParentMixin, class) then
    class:include(ParentMixin)
  end
end
{% endhighlight %}

When the mixin is included, it will check whether the class includes the mixin, and if not, it will include it, therefore simulating inheritance. It's good to check if the class includes the parent mixin, because MiddleClass does not do this itself.

Thanks for reading!
