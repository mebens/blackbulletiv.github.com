---
layout: post
title: Making a 3D Button in CSS
date: 2011-06-05 09:38:44
category: Tutorials
tags:
  - 3D
  - CSS
  - HTML
  - web development
---

In this tutorial I'll be showing you how to create a 3D-looking button, made out of pure CSS. The button we'll be building is similar to the button I've used on my [project pages](/projects). Take note that this uses a number of CSS3 properties, like `border-radius` and `box-shadow`. Anyway, let's get into it.

## The HTML

The only HTML code we'll need is a `div` tag with the proper class:

{% highlight html %}
<div class="big-button">Your Text Here</div>
{% endhighlight %}

If you want the button to link somewhere, just wrap a link round it:

{% highlight html %}
<a href="http://example.com"><div class="big-button">Your Text Here</div></a>
{% endhighlight %}

## The CSS

### The Trivial Stuff

Let's start with the trivial CSS:

{% highlight css %}
.big-button {
  color: #000300;
  background-color: #00910A;
  padding: 10px;
  position: relative;
  text-align: center;
  font-size: 24px;
  font-weight: bold;
}
{% endhighlight %}

So the text colour is basically black, the background color is a green, `position: relative` is something we'll need later, and you can see the rest.

### The 3D Effect

Now let's create the 3D effect. To do this, we'll use `box-shadow`s. Basically, the `box-shadow` property creates a shadow around the shape of the object you apply the shadow to. If we use shadows with no blur applied, we can create something that looks like solid "matter", so to speak. Let's have a look:

{% highlight css %}
.big-button {
  ...
  box-shadow:
    1px 1px 0 0 #014D06,
    2px 2px 0 0 #014D06,
    3px 3px 0 0 #014D06,
    4px 4px 0 0 #014D06,
    5px 5px 5px 0 #000000;
}
{% endhighlight %}

(The format of a shadow is offset x, offset y, blur, spread, and colour. If you want to learn more, look up the property.)

We're using five shadows here. The first four have no blur, and are a much darker green, making it look like less light is being applied to that "side" of the button. Each one of these shadows are 1 pixel over to the right and bottom of the last one, extending the depth of the button. The last shadow is a blurred black shadow, to add to the realism of it (I think :P).

To make sure we can get this to work in as many browsers as possible, we needed apply the same thing to the `-webkit-box-shadow` and `-moz-box-shadow`; whether the `-moz` (for Mozilla) one does anything I don't know, but it may.

To make it look a lot better, we'll add a `border-radius` to make it have curved edges:

{% highlight css %}
.big-button {
  ...
  border-radius: 10px;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
}
{% endhighlight %}

### Push-Down Effect

We want the button to look like it's being pushed down when the user clicks on it. Here's the code to achieve this:

{% highlight css %}
.big-button:active {
  box-shadow: 1px 1px 5px 0 #000000;
  -webkit-box-shadow: 1px 1px 5px 0 #000000;    
  -moz-box-shadow: 1px 1px 5px 0 #000000;
  top: 4px;
  left: 4px;
}
{% endhighlight %}

We're moving the button 4 pixels to the right and bottom, making it look like it's being pushed down. The shadows change to match, and we keep on the black shadow, with a 1 instead of 5 pixel offset.

### Highlight on Hover

To add further to the coolness of the button, we'll make the button fade into a different colour when hovered over. WebKit (Chrome and Safari use it) is the only engine I know of that supports this, so be aware of that. Here's the code:

{% highlight css %}
.big-button {
  ...
  -webkit-transition: background-color 0.2s linear;
  transition: background-color 0.2s linear;
}

.big-button:hover { background-color: #00B00C; }
{% endhighlight %}

## Conclusion

So there you have it, a 3D-looking CSS button. You can get the complete code in CSS of Sass (SCSS) form over at gist #1008528.

Thanks for reading!
