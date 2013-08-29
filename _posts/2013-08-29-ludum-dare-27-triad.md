---

layout: post
title: "Ludum Dare 27: Triad"
date: 2013-08-29 17:35:58
category: Projects
tags:
  - Ludum Dare
  - game development
  - Love2D
  - Ammo

---

For pretty much all of this year I haven't really been doing any game development (nor posts). But I'm starting to get back into it now; a couple weeks ago I started working on my [arena shooter](https://github.com/BlackBulletIV/arena-shooter) again, and now I've participated in the 27th Ludum Dare. It would seem my period for "not participating in the main competition" was only eight months. :P

The game I made is called [Triad](/games/triad). You can download it from the previous link, or rate/comment at its [Ludum Dare page](http://www.ludumdare.com/compo/ludum-dare-27/?action=preview&uid=3915).

## Theme

The theme was "10 seconds", certainly one ripe with potential gameplay mechanics. The choosing of this theme was somewhat telegraphed by its landslide victory in the first round of voting, so I had already had the basic concept for my game planned before the competition even started. I suppose you could count this as one of the things that went right.

My idea was this: you have three soldiers, each of which you play for 10 seconds. Every time you play, the previously played soldiers overlap in time. You use this, in combination with their unique abilities, to destroy all the enemy turrets. This idea was somewhat inspired by the video [Clock Blockers](http://www.youtube.com/watch?v=CBawCe6du3w) and the game [10 Second War](http://tensecondwar.wordpress.com/).

## What Went Right

Thankfully, a lot went right. One of the things I wanted to do in Ludum Dare 25 was use [LÖVE](http://love2d.org); I already had a way of rendering tiles, but didn't manage to import Ogmo Editor's XML files. This time I found a Lua XML library which worked, [SLAXML](https://github.com/Phrogz/SLAXML). So for the first time, I was able to use a proper level editor with LÖVE; a major win.

I'm very pleased with how my idea turned out. I never realised its full tactical and puzzling potential until I actually started to make a few levels. I'm also happy that I had enough time to polish it off and make it feel like a reasonably complete game.

This was my first time really drawing top-down art, and considering that, I think it turned out fairly well. I even managed to animate some basic legs for the player.

Like last Ludum Dare, I set a new record for working hours: 35, much more than anticipated. I was surprised that I was able to churn out that many hours, and it shows in the resulting game I think. And, despite being worn out, it was a much more positive experience this time round.

## What Went Wrong

Almost all of the issues raised in the feedback have been related to the difficulty. The most common thing mentioned is that you can't restart soliders individually, so if you make a mistake on the third or second soldier, you lose all progress on the previously played soldiers. This is obviously annoying, and I wish I'd recognised this as more of an issue when making the game. I'm still not quite sure how it could be solved, because the order in which you plays soldiers is very important, but it's a problem nonetheless.

Initially there was a bug which allowed you to shoot with your shield up, breaking the game's balance. I never noticed it at first, as I never tried shooting with my shield up. Since it only required a small tweak, and was never intentional, I felt it was okay to fix it post-release.

Finally, I wish I had more time make the game look prettier, especially with the tiles of the walls and floor. Luckily I was able to tack on a noise filter to give everything a bit more texture. It helped, but I still wish there was more detail.

## Conclusions

Even though it was sometimes an arduous grind, I had fun this Ludum Dare; the end result was certainly worth it. One thing I've always gotten from these events is a satisfying sense of productivity. Ludum Dare has once again shown me the value of persistent hard work, and actually given me a bit of a taste for it. We'll see how things go, but I reckon I'll be going at it again in Ludum Dare 28.

Anyway, now the three weeks (actually around 19 days at present) of rating begins. Good luck to everyone.
