---

layout: post
title: "Lua for Programmers Part 4: Tips and Tricks"
date: 2012-09-09 11:00:00
category: Tutorials
tags:
  - Lua
  - programming

---

If you haven't read the previous parts ([one](/2012/08/27/lua-for-programmers-part-1), [two](/2012/08/27/lua-for-programmers-part-2) and [three](/2012/09/07/lua-for-programmers-part-3)), then I'd highly recommend doing so. For reference, here's a list of the parts in this series:

* [Part 1: Language Essentials](/2012/08/27/lua-for-programmers-part-1), covers fundamental syntax and concepts such as operators, loops, and functions.
* [Part 2: Data and Standard Libraries](/2012/08/27/lua-for-programmers-part-2), covers Lua's built-in data types and some of the standard libraries.
* [Part 3: More Advanced Concepts](/2012/09/07/lua-for-programmers-part-3), deals with things like variable scope, advanced functions, and file loading.
* Part 4: Tips and Tricks, the current part; a collection of small things that you may find useful.

### Command Line Arguments

Command line arguments are stored in the `arg` table. For example, if we had the script `foo.lua`:

{% highlight lua %}
print(arg[-1], arg[0])
for i, v in ipairs(arg) do print(v) end
{% endhighlight %}

And we ran it via `lua foo.lua arg1 arg2 arg3`, the output would be:

{% highlight text %}
lua foo.lua
arg1
arg2
arg3
{% endhighlight %}

`arg[-1]` is the name of the interpreter/program, generally `lua`. `arg[0]` is the name of the file run. All entries after this are the command line arguments; this allows you to iterate over them as shown in the example.

### `...` in Files

Since files are loaded as functions, it makes sense that you can use `...` inside of them. If we have a file called `bar.lua`:

{% highlight lua %}
print(...) -- prints all arguments given to this file's function
{% endhighlight %}

And then we load it like this:

{% highlight lua %}
loadfile("bar.lua")(1, 2, 3, 4)
{% endhighlight %}

The output will be `1 2 3 4`.

As for the other functions, `dofile` sends no arguments, and `require` sends a single argument with the path it was given:

{% highlight lua %}
require("bar") -- "bar" is the output
require("folder.subfolder.bar") -- "folder.subfolder.bar" is the output
{% endhighlight %}

If you use `...` in the entry-point file (this would be `foo.lua` if you executed `lua foo.lua`, for example) you'll get a list of command line arguments. So if we were to run `bar.lua` via `lua bar.lua arg1 arg2 arg3`, the output would be `arg1 arg2 arg3`.

### `_G`

[`_G`](http://www.lua.org/manual/5.1/manual.html#pdf-_G) is a global table which holds all global variables. Here's an example:

{% highlight lua %}
a = 3
print(_G.a) -- 3
_G.b = 4
print(b) -- 4
print(_G._G == _G) -- true
{% endhighlight %}

### Conclusion

Well, that's it for now. If you've got any suggestions for things that could be added, I'd love hear them.

Thanks for reading the series, I hope it's been of use to you.
