---

layout: post
title: "Lua for Programmers Part 1: Language Essentials"
date: 2012-08-27 14:00:00
category: Tutorials
tags:
  - Lua
  - programming

---

In this series we'll be taking a look at most everything you should know to program in [Lua](http://lua.org). The series is targeted at people who already know how to program, and as such I'll aim to be brief in my explanations.

Here's an overview of the four parts the compose the series:

* Part 1: Language Essentials, the current part; covers fundamental syntax and concepts such as operators, loops, and functions.
* [Part 2: Data and Standard Libraries](/2012/08/27/lua-for-programmers-part-2), covers Lua's built-in data types and some of the standard libraries.
* [Part 3: More Advanced Concepts](/2012/09/07/lua-for-programmers-part-3), deals with things like variable scope, advanced functions, and file loading.
* [Part 4: Tips and Tricks](/2012/09/09/lua-for-programmers-part-4), a collection of small things that you may find useful.

## What is Lua?

In case you didn't already know, Lua is an [interpreted programming language](http://en.wikipedia.org/wiki/Interpreted_language). It's fast, flexible, embeddable, simple, and easy to learn. You can get Lua from its [download page](http://www.lua.org/download.html).

## Some Learning Resources

Two resources that I would recommend for further learning of Lua is the [Programming in Lua](http://lua.org/pil) book (they have the first edition available online) coupled with the [manual](http://www.lua.org/manual/5.2). However, since Lua 5.1 is still the dominant Lua version, I'll be referring to the [5.1 manual](http://www.lua.org/manual/5.1).

A couple other websites you might find useful are the [lua-users wiki](http://lua-users.org/wiki/), and the [Unofficial Lua FAQ](http://www.luafaq.org/).

If you've downloaded Lua and run it from the terminal you'll be able to use an interactive interpreter. This is a very handy tool for learning and experimentation. Here's an example:

{% highlight lua %}
$ lua
Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
> x = 0 
> while x < 10 do 
>> x = x + 2 
>> print(x)
>> end
2
4
6
8
10
> return x
10
> 
{% endhighlight %}

## General Syntax

{% highlight lua %}
--[[
This is
a block comment
]]

if state == 5 then
  doSomething() -- this is a line comment
elseif foo then
  a = true
else
  b = false
end
{% endhighlight %}

There's a small example of Lua syntax. Lua doesn't use semicolons, nor curly braces. However, it does have braces of a sort in the form of keywords like `then` and `do`. The code above also demonstrates conditional statements.

## Variables and Types

Like many other interpreted languages, Lua is typeless, meaning that declaring a variable is as simple as `var = value`. This creates the variable _in the global scope_; we'll soon see how to declare local variables. You can also declare multiple variables at once: `var1, var2, var3 = val1, val2, val3`.

There are few constants, or, types, that you should be aware of:

* `nil` is the nothing value, and also represents undefined variables. While languages such as ActionScript have both a `null` and `undefined` value, Lua combines these two things into one with `nil`.
* `true` and `false` are present. Beware that in conditional statements, the only things that will translate to `false` are `nil` and `false` itself; everything else is considered `true`.

We'll delve more into Lua's native types in [part two](/2012/08/27/lua-for-programmers-part-2).

## Operators

Lua has a mostly standard collection of operators; here they are in increasing precedence ([source](http://lua.org/manual/5.1/manual.html#2.5.6)):

{% highlight text %}
or
and
<     >     <=    >=    ~=    ==
..
+     -
*     /     %
not   #     - (unary)
^
{% endhighlight %}

Here are the differences between your standard C-based operator set:

* The logical AND, OR, and NOT operators are the keywords `and`, `or`, and `not`, respectively.
* The inequality operator is `~=` instead of the standard `!=`.
* `..` is the operator for string concatenation.
* `^` raises a number to a power, for example `10 ^ 2` would yield 100 (or, ten-squared). In most other languages, this performs the binary XOR operation.
* `#` is an operator used to get the length of tables and strings. We'll see this used in [part two](/2012/08/27/lua-for-programmers-part-2).

If you're wondering where bitwise operators are, there aren't any. However, Lua 5.2 added the [`bit32`](http://lua.org/manual/5.2/manual.html#6.7) library which you can use for bitwise operations. If you're using earlier versions of Lua check out [this page](http://lua-users.org/wiki/BitwiseOperators) for some solutions.

Finally, there are two things to note about assignment. First, compound assignment isn't supported. This means an expression such as `i += 3` needs to be written as `i = i + 3`. Second, the syntax of the assignment operator itself is quite limited. You can't do things like `foo(a = 3)` or `a = b = 1`.

## Loops

You've already seen `if` statements, so let's move on to loops. There are four different kinds in Lua.

### `while`

{% highlight lua %}
i = 1

while i <= 5 do
  i = i + 1
  print(i)
end
{% endhighlight %}

Your traditional `while` loop. As you might guess, `print` is the function used to write to the standard output stream.

### `repeat`

{% highlight lua %}
i = 5

repeat
  i = i - 1
  print(i)
until i == 1
{% endhighlight %}  

Repeats its body until the condition is true, and is guaranteed to run the body at least once. Quite like a `do..while` loop.

### Numeric `for`

Lua is a bit different when it comes to the `for` loop. There are two different variations of it, numeric and generic. We'll see the generic variant in [part two](/2012/08/27/lua-for-programmers-part-2).

{% highlight lua %}
x = 1

for i = 1, 11, 2 do
  x = x * i
  print(x)
end
{% endhighlight %}

This loop has the following syntax:

{% highlight lua %}
for var = start, limit, step do
  -- code here
end
{% endhighlight %}

The equivalent `while` loop would be:

{% highlight lua %}
var = start

while var <= limit do
  -- code here
  var = var + step
end
{% endhighlight %}

Or in a C `for` loop:

{% highlight cpp %}
for (int i = start; i <= limit; i += step) {}
{% endhighlight %}

Remember that `step` also takes negative numbers, so you can progress backwards too.
 
### Loop Termination

If you want to prematurely exit from a loop you can use the `break` keyword:

{% highlight lua %}
while true do
  if condition then
    x = x ^ 2
  else
    break
  end
end
{% endhighlight %}

Lua doesn't have the `continue` keyword that many languages have.

## Functions

{% highlight lua %}
function foo()
  local x, y = something(4, 5)
  return x ^ y
end

function something(arg1, arg2)
  local ret1 = (arg1 * arg2) ^ 2
  local ret2 = (arg1 - arg2) ^ 2
  return ret1 + ret2, ret1 * ret2
end
{% endhighlight %}
  
That's how you declare functions. As you can see, the order of declaration in a file doesn't matter as it does in some compiled languages such as C and C++. There are three things I want to point out:

* Lua is a bit different in how local variables are declared. If you want to do so, you need to prefix the declaration with the `local` keyword. We'll learn more about variable scope in [part three](/2012/09/07/lua-for-programmers-part-3).
* Functions can return multiple values. `foo` demonstrates how to capture these values.
* Default arguments aren't directly supported, but there are ways of achieving the same effect which we'll see in [part three](/2012/09/07/lua-for-programmers-part-3).

## Conclusion

Well, that's it for now. Be sure to check out [part two](/2012/08/27/lua-for-programmers-part-2) and the other parts of the series as well. And if you have any feedback, I'd love to hear it.
