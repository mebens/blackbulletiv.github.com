---
layout: post
title: AMFPHP Toolbox 2.1, GitHub, and SOSConnection 1.0.1
category: Projects
tags:
  - ActionScript
  - AMFPHP
  - GitHub
  - releases
---

Well, it's been awhile since I've posted. I've been a lot of stuff lately, so I haven't really had the time to make a post. Anyhow, in this post, I'll cover a few major events.

The first thing I'll talk about is that the NovaFusion AS3 library is now hosted on [GitHub](http://github.com) as of yesterday. I have heard GitHub recommended among developers, and after giving it a try, I can certainly see why. Playing around with their website is an enjoyable experience. Also, Git is the best VCS I've come across (I've only learned a bit of SVN though). It's simple, fast, and intuitive; why would you want to go with anything else? Thanks to the [Pro Git book](http://progit.org/), I had the essentials of Git covered in a few days. Anyway, I encourage to check out the [library's repository](http://github.com/BlackBulletIV/NovaFusion-AS3-Library).

**Update**: My AS3 code has been split up into three repositories now; [amfphp-toolbox](https://github.com/BlackBulletIV/amfphp-toolbox), [SOSConnection](https://github.com/BlackBulletIV/SOSConnection), and [as3-benchmarking](https://github.com/BlackBulletIV/as3-benchmarking).

Probably the biggest event on list is the release of AMFPHP Toolbox 2.1. I'm not going to list out the changes made here, but for more information you can head out to [AMFPHP Toolbox's page](/projects/flash/amfphp-toolbox) on the main website. The one thing I will mention is that this release has a major legacy breaker: the main Connection class has been renamed to AmfphpGateway; this was to make conflicting with other libraries much less of a possibility.

SOSConnection 1.0.1 has also been released. This release fixes a major design flaw in the original 1.0. See the [class' page](/projects/flash/sosconnection).

Anyway, that's about it for now.
