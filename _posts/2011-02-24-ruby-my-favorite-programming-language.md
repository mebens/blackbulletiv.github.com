---
layout: post
title: "Ruby - My Favorite Programming Language"
category: General
tags:
  - programming
  - Ruby
---

Ruby is my new favorite programming language. After about one or two weeks with it, I was sure this was my new favorite. Ruby is a wonderful language, with so many advantages, so I thought I'd write a blog post about it.

Before I found Ruby, I was in a dilema about which programming language was my favorite. I had recently found Lua, and immediately loved syntax, but Lua is nowhere near powerful enough in features to be used all the time (might be one of the reasons why it's fast). There were three programming languages for me that made it hard to choose from: ActionScript, Python, and Lua. I liked ActionScript because of it's solid, pure, object-oriented implementation. I liked Python because of it's an interpreted language, but still has a lot of power. I liked Lua because of it's awesome syntax. I wished for something that would blend all of this into one language. Ruby is just that.

## Object-Oriented

Ruby goes above and beyond the call of duty here. It's more object-oriented than any other language I've worked with (wonderful for me). Everything you manipulate is an object (like ActionScript), but it takes it further by doing stuff like this (I can't really explain, so I'll give the code):

{% highlight ruby %}
6.567.ceil # = 7 - instead of Math.ceil(6.567)
-3.abs # = 3 - instead of Math.abs(-3)
# although, you can't do stuff like x.sin, x.cos for example
{% endhighlight %}

I love this kind of thing, it sits really well the object-oriented nut inside me.

Another thing I really like, is that you can extend classes and modules (we'll get to modules in a sec). Take this example, where I extend the String class to see whether a string is a palindrome:

{% highlight ruby %}
class String
  def palindrome?
    self == self.reverse
  end
end

"wow".palindrome? # = true
"false".palindrome? # = false
{% endhighlight %}

This allows for some fantastically awesome stuff to occur; the skies are the limit.

Finally, modules used as mixins are a fantastic feature for creating reusable functionality.

{% highlight ruby %}
module MyMixin
  def reusable
    # ...
  end
  
  def more_reusable_stuff(foo, bar = 3)
    foo * (bar ** 2)
  end
end

class Whatever
  include MyMixin
end

x = Whatever.new
x.reuseable # valid method call
x.more_reuseable_stuff(4) # 36
{% endhighlight %}

With this, functionality in the mixin can be included from anywhere, which is wonderful for keeping code DRY (Don't Repeat Yourself).

## Powerful

Seriously, Ruby is really powerful. It comes packed with many awesome, easy-to-use classes, and a huge standard library. The standard library even includes the WEBrick web server, and a network library for sockets, and HTTP, FTP, and a number of other protocols.

Ruby has a lot to offer for string processing as well. It's got regular expressions built right in, and the String class has over 100 methods to help out. Let's take a look at a nice little example:

{% highlight ruby %}
"hEllO woRLd my NAME iS soMEboDy".capitalize.gsub(/\.$/, '') << '.' # "Hello world my name is somebody."
{% endhighlight %}

You can do a lot on one line with Ruby, it's very compact. What this basically does, is make sure that the first letter in the string is capitalised and the rest is lowercase, and that it ends with a fullstop if one isn't already there. It uses a regular expression to take out any ending fullstop, and then puts one on the end. We only used three methods here (capitalize, gsub, and, <<, an operator). A few more examples of compactness:

{% highlight ruby %}
s.gsub(/'|"/, '').split.map {|v| v.capitalize }.join # removes quotes, capitalises all words and joins them all back together without spaces: "I'm a Person" = "ImAPerson"
('a'..'z').to_a.shuffle[0..10].join # random 10 letter string
(('a'..'z').to_a * 2).shuffle[0..42].join # random 42 letter string
{% endhighlight %}

That code uses ranges and blocks. Think of ranges like saying 'a' up to 'z', or 3 up to 90, for example. Blocks are like anonymous methods, except that have loop like controls such as `break` and `next`.

One final thing that's really cool, is the fact that (at least most) control statements are expressions themselves:

{% highlight ruby %}
something = if i_am_weird
              michaels_weird! # method call (! is included in name
            else
              phew
            end
{% endhighlight %}

## Beautiful Syntax

The syntax of Lua looks like this:

{% highlight lua %}
function whatever()
    if something then
        somethingRather()
        
        for i, v in ipairs(table) do
            print(i)
        end
    else
        somethingOther()
    end

    print("Done!")
end
{% endhighlight %}

I loved the syntax without braces, instead using end statements. Ruby is like this, but it takes cool syntax further. In Ruby you don't have to use parenthesis for methods:

{% highlight ruby %}
def no_parens arg1, arg2
end

no_parens 1, 2
{% endhighlight %}

This lets you do all kinds of cool syntax, and allows you to almost make a complete DSL inside of Ruby. You have to be careful of course, and using parenthesis is always a good idea when mixed with other expressions (I never declare methods without parenthesis either).

Finally, Ruby lets you use three special characters at the end of method names, which is especially useful when using methods that return true or false:

{% highlight ruby %}
def possibly_dangerous!
  prepare_dynamite!
  move_workers_out
  kaboom!
end

def palindrome?(string)
  string == string.reverse # implicit return statement
end

class Foo
  def set_something=(value)
    # ...
  end
end
{% endhighlight %}

## Conclusion

Overall, Ruby is a fantastic language, which I highly recommend checking out. It blends together some of my favorite things in programming languages. I do have some disagreements with it, mainly on code style, but they're only minor.

Mind you, I had trouble getting used to two spaced indenting. Ruby doesn't require you to do so, but it seems it's an enforced standard in the Ruby community (and when you start using Rails with it's code generation, it's futile to resist).

If you've read all that, congratulations!
