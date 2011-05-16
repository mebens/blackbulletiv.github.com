---
layout: post
title: My Thoughts on Flash
category: General
tags:
  - CSS
  - Flash
  - HTML
  - HTML5
  - JavaScript
  - web development
---

I used to do a lot in Flash. In fact, my first programming language was ActionScript 3. I hacked around for quite some time trying to get Flash to talk to PHP, and eventually figuring out AMFPHP, going on to create the [Using AMFPHP](http://www.youtube.com/user/BlackBulletIV?feature=mhum#p/c/30526DF66C1E2C84/0/h7MUSkBA1xc) tutorial series, and [AMFPHP Toolbox](/projects/flash/amfphp-toolbox). In this post, I'm going to share my current thoughts on Flash, and it's current place in my toolkit.

As I said, I _used_ to do a lot in Flash; but I don't nowadays. That's largely because I'm focused on other  things, but it's also because I now try to do everything that is practical in web technologies like HTML/CSS/JavaScript. Why? Because Flash does chew up a fair amount of resources, and it's not integrated with the web browser's runtime as well.

I think the resource usage comes largely from the fact that Flash is a completely separate runtime, with it's own virtual machine. I'm not sure whether a virtual machine is started up on every instance of Flash in a page (I sure hope not!), but I do know that with every instance of Flash on a page, the memory usage goes up (and CPU too, depending on what the Flash instances are doing of course). However if all this stuff was done in JavaScript, it would only be one runtime, and that is the browser with its JavaScript engine and DOM. The only trouble that you run into is browser compatibility, largely thanks to Internet Explorer, which is most certainly a glitch in software history.

These days I'm excited by the developments in the web technologies, as in, HTML 5. If we can do video/audio natively, jolly good! If we can draw natively with canvas and WebGL, awesome! But I'm not one of those who thinks that Flash is going out the door. Even when HTML 5 is pretty mature and has wide support, I think Flash will still have a purpose. It'll be there as a fall back, in case we can't use HTML 5; which I'm sure will be ensured by IE 7/8 (maybe even 9?) for a while to come. And for stuff like web games I think Flash is very appropriate. If I wanted to develop a game for the web, I'd most certainly do it in Flash.

In summary, I'm very excited to see the new developments in HTML 5, and I now prefer to do things using web technologies. Flash definitely has its place, but I would rather use web technologies in most cases. So what do you think about the whole issue?
