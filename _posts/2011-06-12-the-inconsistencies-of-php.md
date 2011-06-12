---
layout: post
title: The Inconsistencies of PHP
date: 2011-06-12 10:56:28
category: General
tags:
  - PHP
  - C
  - programming
  - web development
---

Over the past few months I've come to love the Ruby programming language for many reasons. After using this language for a while and having a blast of a time, when I came back to PHP, I found it disgusting. I used to love the language; my tastes of syntax have definitely changed, but one thing that really bugged me as I examined PHP closer, is its inconsistencies. As you can tell by the title, this blog is going to be a little rant of a few of the inconsistencies I've noticed in PHP.

## The API and OOP

PHP started as a very C-like procedural language; some core OOP stuff was added in PHP 4, and expanded a lot in PHP 5. The problem with PHP's beginnings is that most of its API is all procedural and function-based. For example, in PHP to push an element onto an array you would use `array_pop($a, $value)`, whereas if PHP were more object-oriented it would be `$a->pop($value)`. Same goes for strings and most other functions.

This brings up another point. All the core types are these strange values and not objects, nor types (since PHP doesn't have a typing system). This is another showing of its C heritage.

All this equates to a feeling of inconsistency when your own code is OOP, but the language's API is function-based. This of course comes from the fact that PHP started out like C, but then they tried to introduce OOP midway in the language's development, and because they can't massively break compatibility in order to make the API consistent, everything ends up feeling messy.

## `else if` and `elseif`

This is a syntax inconsistency. PHP contains an `elseif` keyword, which is the same as `else if`. For some reason, it's encouraged that you use `elseif`, maybe because a slight performance increase, I don't know. But anyway, `else if` is what you use in C; it's a result from C's block syntax:

{% highlight c %}
// all these are the same...

else if (something)
{
  
}

else
  if (something)
  {
    
  }

else
{
  if (something)
  {
    
  }
}
{% endhighlight %}

I'm one that tends to like (to a great extent) Python's philosophy of having only one obvious way to do things, and this totally breaks that rule.

## Interfaces

Interfaces were added in PHP 5, which obviously come from Java (or Objective-C's protocols), and a way of requiring a class to implement a certain set of methods. In a languages with types (like Java and Objective-C) this is a good thing, since the interface itself can be treated as a type and all objects which conform to it are compatible with that type. But in a typeless language I don't see the need for it, as duck typing would eradicates the need to be ensured that a certain set of methods can be called on an object.

I think something like Ruby's mixins is a much better idea for a language without types, where a set of methods is included into a class. As you might know, traits (which are basically mixins) are being added in PHP 5.4, but this means that now PHP will have _both_ interfaces and traits. Sounds like a bit of feature bloat to me.

## Conclusion

In my opinion, PHP's problem is design inconsistency. It started with C-like design, and then had features added to it, creating a non-harmonious blend of designs. Whereas, for example, Ruby was designed from the start to be fully object-oriented, leaving a far more consistent design.

If you have something to say then leave a comment below, I'd like to hear your opinion on this. Thanks for reading!
