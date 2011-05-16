---
layout: post
title: AMFPHP Toolbox v2 Final Released!
category: Projects
tags:
  - ActionScript
  - AMFPHP
  - releases
---

The final version of AMFPHP v2.0, my ActionScript library for working with AMFPHP, has been released. A number of things have been changed since the beta version and I'm going to go over them here.

## CallQueue

First of all I'll introduce the new CallQueue class. This class acts has some similarities with CallSet, and it's functionality is to move a list of call objects up a queue (in the first in first out order) calling them as limitations allow. Say we have 10 calls to make, and we put them in a queue like this:

{% highlight actionscript %}
var q:CallQueue = new CallQueue(nc,
  new Call("service.method", "param"),
  new Call("service.method", "param"),
  new Call("service.method", "param"),
  ...
);
{% endhighlight %}

In this example, we've created a new CallQueue object, passed in our connection object (named nc) and passed in the call objects. To start this queue moving a long we can call this method:

{% highlight actionscript %}
q.start();
{% endhighlight %}

This will start the queue moving and the first member we added to the queue, is called. When a call is called it goes into a "hanging" state, meaning it's waiting for either a result or fault. By default, no other calls can be called while another call is in a hanging state. You can change how many calls can be in a hanging state by adjusting the concurrentCalls property. When a call receives a result, it's moved out of the way, and the queue moves on.

## Internal Data Structure Re-working

The internal structures of data in v2 beta were a bit messy and didn't really work as well as they should. Since then I've come across an awesome AS3 library called [as3ds](http://lab.polygonal.de/ds/) which contains a number of really handy classes that deal with different structures of data. These are now used in many places throughout the library, and because of this NovaFusion ActionScript code will now be bundled with the as3ds library.

This change doesn't really affect the public API, but it certainly affects the guts of the system.

## Adjustments to the Listening System

Some adjustments have been made to the listening system for results and faults with calls. The system has been simplified a bit (at least the code in the classes has), and also now has support for multiple listeners on calls. The Call object now has method inside to add listeners to that particular call. The methods for adding listeners in the Connection object still do their thing, but actually use the methods in the Call objects themselves.

## Moving of Event Constants

The custom event constants have been moved around a bit, resulting in the destruction of the AMFPHPEvent class. The RESULT and FAULT constants have been moved to the CallEvent class (where they belong) and the TIMER_CALL constant has been deleted and TimerEvent.TIMER, is now being used instead.

## Conclusion

Over the next few days I'll be making some changes to things that need be changed in the tutorials, and hopefully writing some new tutorials on how to use the library. Sometime in the future I should be making some video tutorials on how to use it as well.

Well, that's a brief overview of the new release of AMFPHP Toolbox. I hope you find it of some use, and please contact me if you experience any or bugs, have any feature requests, or have any feedback.
