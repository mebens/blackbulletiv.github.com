---
layout: post
title: Some Uses for the Modulos Operator (%)
category: Tutorials
tags:
  - maths
  - programming
  - Ruby
---

I've been learning about a few of the awesome things you can do with the modulos operator lately. For those who don't know, the modulos operator (the percent symbol in code) gives the remainder of dividing two numbers. Therefore, `10 % 4` equals 2, because 4 goes into 10 two times, and what we have left is the number 2. Now let's get into what we can do (note, I'll be using Ruby code here, but it won't make much difference, as it's all about a single operator).

First of all, you can check whether a number is a multiple of another number:

{% highlight ruby %}
10 % 5 == 0
10 % 6 != 0
{% endhighlight %}

If the result is 0, the number on the left is a multiple of the number on the right. Similar to this, we can check for even (and odd) numbers:

{% highlight ruby %}
if i % 2 == 0
  -- even
else
  -- odd
end
{% endhighlight %}

This is the same as using `i & 1 == 0`.

Modulos can be used to limit a number, like an iterator, to under a certain value. Take this example of iterating through an array:

{% highlight ruby %}
i += 1
i = 0 if i >= max
print(array[i])
{% endhighlight %}

That can now be turned into:

{% highlight ruby %}
print(array[(i += 1) % max])
{% endhighlight %}

This behaviour can also be used on rotations:

{% highlight ruby %}
rotation %= 360
-- do processing
{% endhighlight %}

Finally, you can use modulo for moving across a grid with rows and columns. Let's have a look:

{% highlight ruby %}
0.upto(slots - 1) do |i|
  row = (i / rowLength).floor
  column = i % rowLength
end
{% endhighlight %}

And for those of you who are wondering what on earth is going on, here's a Cish translation:

{% highlight cpp %}
for (int i = 0; i < slots; i++)
{
  int row = floor(i / rowLength)
  int column = i % rowLength
}
{% endhighlight %}

So basically, we're iterating through the total number of slots in the grid and we need to work out the row and the column. We can work out the row by dividing our current position by the number of slots in a row. We can work out the column by "modulosing" our current position by the number of slots in a row, that same kind of warping behaviour we saw in rotations and iterating through arrays.

Anyway, that's all for now. Thanks for reading.
