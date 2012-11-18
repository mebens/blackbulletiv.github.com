---

layout: post
title: "Linked Lists in Lua"
date: 2012-11-16 14:31:32
category: Tutorials
tags:
  - Lua
  - programming

---

As an example of creating custom data structures in Lua, I thought I'd give a little demonstration of a [linked lists](http://en.wikipedia.org/wiki/Linked_list) implementation. Note that this isn't going to be an in-depth tutorial or anything; for the most part I'll just be showing pieces of the code.

Linked lists are wonderful data structures, perfect if you need to efficiently add, remove, and iterate through elements. The one trade off is that you can't find an element by an index.

There are a few kinds of linked lists, the two most common are singly and doubly linked lists. Every kind of linked list hold a bunch of nodes which maintain references to each other. A singly linked list holds a reference to the first node, and each node holds a reference to the next node. A doubly linked list holds a reference to the first and last nodes, and each node holds a reference to the next and previous nodes. Take a look at the [Wikipedia page](http://en.wikipedia.org/wiki/Linked_list) if you want more details.

I've decided to implement the doubly linked list. It's not quite as efficient the singly linked list, but it's more versatile as it allows reverse iteration. Let's start with some basic OOP:

{% highlight lua %}
list = {}
list.__index = list

setmetatable(list, { __call = function(_, ...)
  local t = setmetatable({}, list)
  for _, v in ipairs{...} do t:push(v) end
end })
{% endhighlight %}

This allows the user to create new linked lists like this:

{% highlight lua %}
x = list(a, b, c, d)
{% endhighlight %}

Note that all the elements must be tables to support the holding of references.

The first function I'll show is the simple `push` function. It appends an element to the end of the list:

{% highlight lua %}
function list:push(t)
  if self.last then
    self.last._next = t
    t._prev = self.last
    self.last = t
  else
    -- this is the first node
    self.first = t
    self.last = t
  end
  
  self.length = self.length + 1
end
{% endhighlight %}

And here's the corresponding `pop` function, which removes the last element from the list and returns it:

{% highlight lua %}
function list:pop()
  if not self.last then return end
  local ret = self.last
  
  if ret._prev then
    ret._prev._next = nil
    self.last = ret._prev
    ret._prev = nil
  else
    -- this was the only node
    self.first = nil
    self.last = nil
  end
  
  self.length = self.length - 1
  return ret
end
{% endhighlight %}

For some more flexibility in where and what we add and remove, here's the `insert` and `remove` functions:

{% highlight lua %}
function list:insert(t, after)
  if after then
    if after._next then
      after._next._prev = t
      t._next = after._next
    else
      self.last = t
    end
    
    t._prev = after    
    after._next = t
    self.length = self.length + 1
  elseif not self.first then
    -- this is the first node
    self.first = t
    self.last = t
  end
end
{% endhighlight %}

{% highlight lua %}
function list:remove(t)
  if t._next then
    if t._prev then
      t._next._prev = t._prev
      t._prev._next = t._next
    else
      -- this was the first node
      t._next._prev = nil
      self._first = t._next
    end
  elseif t._prev then
    -- this was the last node
    t._prev._next = nil
    self._last = t._prev
  else
    -- this was the only node
    self._first = nil
    self._last = nil
  end

  t._next = nil
  t._prev = nil
  self.length = self.length - 1
end
{% endhighlight %}

`insert` inserts the element into the list after the node specified by `after`. If `after` isn't specified, it will only add the element if no other nodes exist the list. `remove` is capable of removing the first or last element, or anything in between them.

The final thing we'll look at is iterator support:

{% highlight lua %}
local function iterate(self, current)
  if not current then
    current = self.first
  elseif current then
    current = current._next
  end
  
  return current
end

function list:iterate()
  return iterate, self, nil
end
{% endhighlight %}

This is forward iteration only, but it isn't hard to implement a reverse iterator.

To cap things off, here's a usage example:

{% highlight lua %}
require("list")

local a = { 3 }
local b = { 4 }
local l = list({ 2 }, a, b, { 5 })

l:pop()
l:shift()
l:push({ 6 })
l:unshift({ 7 })
l:remove(a)
l:insert({ 8 }, b)
print("length", l.length)
for v in l:iterate() do print(v[1]) end
{% endhighlight %}

If you'd like the full source, plus some extra functions, check out gist #4084042.
