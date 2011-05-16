---
layout: post
title: "Strong: Make Your Strings Stronger in Lua"
category: Projects
tags:
  - Lua
  - programming
  - releases
---

For the last few days I've been working on a library called "strong". It's a string enhancement library for Lua. Strong adds a few operators to strings, and many methods to Lua's string library. I've already written more information in the [README](https://github.com/BlackBulletIV/strong#readme) and the [wiki](https://github.com/BlackBulletIV/strong/wiki), which you can go to for more information. Here's the direct link to the [GitHub repo](https://github.com/BlackBulletIV/strong) by the way.

After much testing and refinements, I've just released version 1.0 of the library. Finally, here's an example straight from the README of a little of what the lib can do:

{% highlight lua %}
s = "Hello world.\nBoo. This is cool.\nHey!"

for line in s:lines() do
  local sentences = line / '.%s*'

  for _, s in pairs(sentences)
    print(s:capitalize())
  end
end
{% endhighlight %}

Enjoy!

**EDIT:** Here's the [project page](/projects/lua/strong).
