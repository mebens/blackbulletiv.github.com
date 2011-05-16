---
layout: post
title: Making a Dynamic Copyright With PHP
category: Tutorials
tags:
  - PHP
  - time
  - web development
---

I though I'd just write a quick tutorial on how I make a dynamic copyright for my websites. If you don't know what a function does in the code, look it up on the PHP manual.

{% highlight php %}
echo strftime('%Y', time());
{% endhighlight %}

That's the year generating code. It's just grabbing the year from the current timestamp. So we could do something like this in the copyright:

{% highlight php %}
&copy; <?php echo strftime('%Y', time()); ?> Legion of Weirdos.
{% endhighlight %}

You might want to wrap around the code in a helper function:

{% highlight php %}
function year()
{
    return strftime('%Y', time());
}
{% endhighlight %}

Anyway, that's all folks.

