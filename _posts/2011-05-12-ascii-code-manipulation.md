---
layout: post
title: ASCII Code Manipulation
category: Tutorials
tags:
  - C
  - programming
  - text manipulation
---

While inspecting the [ASCII table](http://www.asciitable.com) a little while ago, I noticed some interesting patterns in it, which can be used for string manipulation. It's important to understand the ASCII table, because it's the base of most encodings.

Note I'll be using C-like syntax in my examples, but I won't be taking advantage of C's characters, which convert stuff like `'a'` into `97` (a's ASCII code).

## An Introduction

For those who don't know what much about ASCII codes, I'll give you a quick introduction. ASCII stands for "American Standard Code for Information Interchange", which assigns certain numbers to certain common characters. Since computers can only work with numbers, every letter, or character of any sort, must have a number associated with it. ASCII assigns numbers to 128 different commonly used characters (although many of the non-print characters are no longer used for their original purpose).

## Sorting Order

The characters given in the ASCII table are how things are sorted alphabetically. So for example, 'B' (which is 66) comes before 'a' (97). This allows us to determine whether a string should come before another string by just checking whether its ASCII code is less than the other's code:

{% highlight cpp %}
int x = 66; // B
int y = 97; // a
if (x < y) ...
{% endhighlight %}

With this knowledge we can also get the next or previous character in alphabetical order simply by adding or subtracting by 1:

{% highlight cpp %}
int x = 66; // B
int y = 97;
x--; // x is now 'A'
y++; // y is now 'b'
{% endhighlight %}

## Is This Upper or Lower Case?

We can also check whether a character is upper or lower case, by checking whether its code is between a certain range. For upper-case, this range goes from 65 to 90; for lower-case it's 97 to 122. Therefore we can do this:

{% highlight cpp %}
x = 66; // B
y = 97; // a
if (x >= 65 && x <= 90) ... // it's upper
if (y >= 97 && x <= 122) ... // it's lower
{% endhighlight %}

## Swapping Cases

Now there's a cool relationship between upper and lower case characters: if you want to get the upper-case equivalent of a lower-case character, simply subtract 32 off its code. The same goes upper-case to lower-case, except the other way round. Therefore we can do this:

{% highlight cpp %}
x = 66; // B
y = 97; // a
x += 32; // x is now 'b'
y -= 32; // y is now 'A'
{% endhighlight %}

## Conclusion

Anyway, that's all for now. Thanks for reading!
