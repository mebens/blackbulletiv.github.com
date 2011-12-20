---
layout: post
title: "Ludum Dare 22 Postmortem"
date: 2011-12-20 11:54:16
category: Projects
tags:
  - game development
  - Flash
  - FlashPunk
  - Ludum Dare
---

![A couple of in-game screenshots](/games/uncorrupted/images/combo-screenshot-1.png)

Last weekend was [Ludum Dare](http://www.ludumdare.com) 22, and of course, I participated. The game I created is entitled Uncorrupted; there's more information available at its page [on my website](http://nova-fusion.com/games/uncorrupted) and [on Ludum Dare](http://www.ludumdare.com/compo/ludum-dare-22/?action=preview&uid=3915). You could also check out the [time-lapse](http://www.youtube.com/watch?v=LOIeBoSi5_Q) of my work on the game.

## Preparation

Anyway, with that aside, here's my postmortem. As always, it's important to prepare beforehand, especially making sure that your toolchain works. I decided to use FlashPunk this time, firstly because I'm very familiar with it right now, thanks to my work on Illusive Dreams, and secondly because web games are much more accessible for people to test.

To make sure everything in my toolchain was working alright, I made a small little "game" a few days before the event. I didn't finish it or anything (hence the quotes around "game"), but it was enough to make sure everything was operational.

But anyway, preparation and planning are very important to successfully getting through Ludum Dare. I learnt that on my first Ludum Dare (the 20th).

## Creating an Idea

The theme this time was "Alone", something a bit more complicated, in my opinion, than the likes of "Escape" (the last theme). It took much longer than last time to settle on a concept for the game. First I decided I'd do some kind of top-down game, but after working on that for a bit, I decided a 2D platformer would be better. Fortunately I didn't have to change much to make the switch. Choosing to go with a 2D platformer was very helpful because, again thanks to Illusive Dreams, I'm very familiar with that type of at present.

While programming the platforming mechanics I was still wondering what theme of the game would be. Would you be an AI program stuck alone inside a simulated environment? Would you be some guy alone in a cave? Would there be enemies? Eventually I settled on a memoryless robot inside a research facility, in which all the researchers have been killed... by something.

## Art

Art is always something I struggle with, especially in such a short timeframe. I drew quite a few player sprites before I got the robot that you see in the game. Since the movement of limbs I something I especially struggle with, I made the robot have some kind of wheel attached to it that it uses to move. Those kind of things are a lot easier to animate. I did the same thing with the enemies, except I don't think it turned out as well.

One thing I'd like to point out is the colours used. Almost everything is a shade of grey (black and white are shades of grey of course), except for the blood, the "eyes" of the enemies (both being shades of red), and the skin on the faces of dead researchers. After creating some white tiles, I decided I'd stick with shades of grey, primarily for ease of drawing. Upon further examination, I'd say that the greyness adds to the feeling of emptiness/loneliness.

## Sleep and Work

I decided before hand that this Ludum Dare I was going to spend more time working, and less time sleeping; both definitely happened. I slept for ~14 hours, and worked for ~18.5 in Ludum Dare 21; this time I slept for ~9, and worked ~26. Sleep depravation certainly reduces productivity, I was really slow and wasted by the end of Sunday night, having been awake for 20 hours. The funny thing is, I was noticing the tiredness less, but getting slower in productivity.

Upon reflection, I think I enjoyed the experience of Ludum Dare 21 more, mainly because I didn't push myself so hard. I guess that's the trade off: which do you want to enjoy more, the end product, or the experience of making it? Personally I favour a better game, for many reasons which I think are obvious.

## Features Left Out

Of course, there were a number of features left out that I wanted to add. From the start, I wanted the player have limited ammo, but I had to drop the idea because I thought it would take too long. Now looking back, if I pushed a bit harder I'd say I could've done it.

I planned to add more enemy types, not just "rolling ball with black metal over it." You can see this because the [`Enemy`](https://github.com/BlackBulletIV/uncorrupted/blob/master/entities/Enemy.as) class only has one subclass ([`Roller`](https://github.com/BlackBulletIV/uncorrupted/blob/master/entities/Roller.as)). Some of the types I considered were turrets and some kind of walking robot. But, both would've taken out a fair amount of time, and after a while I could see that it wasn't doable.

## Productivity

I'm constantly amazed at how productive you can be during Ludum Dare. It's a combination of the very tight deadline and the desire to make something awesome within it. For me, this makes me focus solely on making the game during the 48 hours. I'm thinking of doing something similar with my regular work every now and then. I'd give myself a focus and then just work on that for most of the day.

But anyway, the bottom line is, it's truly amazing what one can accomplish in just 48 hours.

## Conclusion

Well, as usual, I've had a lot of fun this Ludum Dare and look forward to the next one. I'm pretty sure my game is significantly better in quality than my last Ludum Dare game (the [feedback](http://www.ludumdare.com/compo/ludum-dare-22/?action=preview&uid=3915) so far is highly positive), so hopefully I get some higher rankings than last time. But, one thing I've learned with Ludum Dare is not to get your hopes up; there's a tonne of really talented developers out there.

Thanks for reading, and good luck to all the developers who participated!