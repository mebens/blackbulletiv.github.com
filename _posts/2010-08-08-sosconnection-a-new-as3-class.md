---
layout: post
title: "SOSConnection - A New AS3 Class"
category: Projects
tags:
  - ActionScript
  - releases
---

Today I released a new ActionScript 3.0 class. It's called SOSConnection, and in short it speeds things up when sending messages to SOS max.

Just in case you don't know, here's a brief overview of [SOS max](http://www.sos.powerflasher.com/). It's a socket server made by [Powerflasher](http://www.powerflasher.com/), which allows you to send messages from Flash to the server and provides a graphical interface to view them in. It's sort of a much more advanced trace() function, and is handy for outputting debugging data when you can't use the trace() function. To learn more about SOS max and how to use it, visit it's [website](http://www.sos.powerflasher.com/).

SOSConnection helps by dealing with XMLSocket connection for you. It also provides a number of helpful functions that only require you to pass in what you care about, the actual message you're sending. If you want to learn more about the class visit it's [page](/projects/flash/sosconnection) on my website and view it's [ASDoc documentation](/media/docs/SOSConnection/index.html?com/novafusion/net/SOSConnection.html).

Please let me know if you experience any bugs, have any feature requests or any feedback. Thanks!
