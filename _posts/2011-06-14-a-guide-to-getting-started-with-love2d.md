---
layout: post
title: A Guide to Getting Started with Love2D
date: 2011-06-14 12:59:03
category: Tutorials
tags:
  - programming
  - game development
  - Love2D
  - Lua
---

In this post, I'll attempt to give you my personal guide on some good steps to getting started with the [Love2D](http://love2d.org) game engine (the proper name is LÖVE, which I'll be using from now on). It's not perfect, of course, but I hope you find it useful. If you have any feedback, I'd love to hear from you in the [comments](#respond).

## What is LÖVE?

I'm guessing you probably already know, but for those who don't, LÖVE is a 2D game engine (or, framework). It's an environment which contains a lot of pre-written code targeted at making games. It interfaces with the [Lua](http://lua.org) programming language to makes things even easier for you.

Compared to other 2D engines, LÖVE is the best I've seen so far. Its API (Application Programming Interface) is very simple and (usually) intuitive, Lua is a great language, the environment in general is nice, and the community is very friendly and supportive. Oh yeah, it's totally free and open-source too, licensed under the very liberal [zlib/libpng license](http://www.opensource.org/licenses/Zlib).

So, if you want to learn how to use LÖVE, read on.

## Getting Set Up

First thing to do is go and download the engine for your operating system over at [its homepage](http://love2d.org). Then proceed to install it. You'll probably want install Lua as well; you can get it from the [download page](http://www.lua.org/download.html), this will allow you to play around with Lua interactively using the `lua` command. You don't have install Lua to run games however, as Lua is included inside of LÖVE.

Next, make sure you've got a text editor installed. Here's a few of my recommendations:

* [Notepad++](http://notepad-plus-plus.org/): free, for Windows.
* [TextWrangler](http://www.barebones.com/products/textwrangler/): free, for Mac.
* [Sublime Text 2](http://www.sublimetext.com/2): paid, for all platforms.
* [gedit](http://projects.gnome.org/gedit/): comes pre-loaded on Ubuntu and similar Linux distributions.
* [TextMate](http://macromates.com): paid, for Mac. I'd personally recommend Sublime Text 2 over this.

Next, if you're on a Mac, you'll want to do the following to make it easier to run games from the terminal. Open up your text editor with a file located at `~/.bash_profile` (you may have to do this with the Terminal) and copy the following into it:

    alias love="/Applications/love.app/Contents/MacOS/love"

If you placed `love.app` in the `Applications` folder, this will allow you to run LÖVE games from the terminal with the `love` command.

## Lua

The Lua programming language is how you'll tell LÖVE what to do. If you don't already know Lua, you'll definitely want to learn the fundamentals of it before diving into LÖVE. If you've already got some programming experience, I'd recommend my [Lua for Programmers](/2012/08/27/lua-for-programmers-part-1/) series. The other place you could go is the official [Programming in Lua](http://lua.org/pil) book (often abbreviated as PIL).

If you don't have any previous programming experience, the only place I can really point you to is Google and the afore mentioned book. You could also try getting a bit of experience in some other programming language and then come back to Lua.

## Game Structure

Once you've got some Lua under your belt, you need to know what a LÖVE game is made of. Fortunately, LÖVE places few requirements on how you structure your game. First, you must create a folder and name it whatever you want. Second, you must create a file inside this folder called `main.lua`. This Lua script is run when the game starts up; from here you can load other scripts, resources, and so on. Finally, you must place everything your game needs (images, music, code, etc.) inside this folder.

### .love Files

One thing you'll need to know about when using LÖVE is .love files. These files are the standard way of packaging a game's folder into a single file. Really, they are just zip files containing the contents of the game, except renamed with a `.love` extension. This allows them to be double-clicked or dragged over the `love` executable/application and run.

There are two things to keep in mind. First, your `main.lua` file must be top-level in the zip file. This means that you should zip the _contents_ of the game's folder, not _the folder itself_. Second, file and directory path names inside a .love file are case sensitive; so you can't rely on your filesystem's case insensitivity.

Now, here's how to make a .love file (information taken from the [wiki page on game distribution](http://love2d.org/wiki/Game_Distribution)):

#### Windows

* Create a new zip file (built into XP, Vista, and 7).
* Copy all the files from inside your game's folder into the new zip file. (If you make a zip file containing the game's _actual folder_, it won't work.)
* Check that you can see file extensions. Press Alt, go to folder options, and make sure "Hide extensions for known file types" is unchecked.
* Rename the zip file's extension from .zip to .love.

#### Mac/Linux

* Open up a terminal.
* Change your current directory to your game's directory using the `cd` command. For example if your game is located at `~/Projects/EpicGame` you would type in `cd ~/Projects/EpicGame` then press return (this is called executing a statement).
* Then execute `zip -r ../${PWD}.love *`.
* A .love file named the same as your game's folder will be located in your game's parent folder. So, if your game was located at `~/Projects/EpicGame` the file would be `~/Projects/EpicGame.love`.

For more information on making .love files and distributing games, check out the [wiki page](http://love2d.org/wiki/Game_Distribution) on the subject.

## LÖVE's API

Well, with all that out of the way, your next task is starting to learn LÖVE's API. There's quite a lot in it, and in this section I'll give you a quick walkthrough on how to approach it. Before I start, I'll point you to [LÖVE's wiki](http://love2d.org/wiki/), which contains a complete API reference (see the "Documentation" section in the sidebar for links to the modules).

The API is divided up into modules. Every module (which is just a table) lives inside the module (again a table) named `love`. Examples of modules are [`love.graphics`](http://love2d.org/wiki/love.graphics) and [`love.filesystem`](http://love2d.org/wiki/love.filesystem). Each of these modules contains functions which do certain things. For example, [`love.graphics.circle`](http://love2d.org/wiki/love.graphics.circle) allows you to draw a circle to the screen.

Many modules also contain classes which serve a certain purpose, usually the storage and manipulation of some kind of data. For those who aren't familiar with object-oriented programming (OOP), jump down to the Object-Oriented Programming section below. Most of the time you will create instances of these classes via a module function with a name beginning with `new` followed by the class name. For example, [`love.graphics.newImage`](http://love2d.org/wiki/love.graphics.newImage) creates a new instance of the [`Image`](http://love2d.org/wiki/Image) class.

The first thing in the API you should take a look at is the callback functions located in the [`love`](http://love2d.org/wiki/love) module, which are called at key stages in the game loop. Have a look at the [tutorial for callbacks](http://love2d.org/wiki/Tutorial:Callback_Functions) on the wiki to get started.

Once familiar with those, it's time to look at some modules. You don't have to learn them all, half of them you won't need for a simple game; it all depends on what you want to do. Firstly get familiar with [`love.graphics`](http://love2d.org/wiki/love.graphics); it may be the biggest module, but you don't need to know all of it. Probably the best things to take a look at are the drawing functions, and some of the classes.

Next you'll want to at least familiarise yourself with how LÖVE handles files. Have a read of [`love.filesystem`](http://love2d.org/wiki/love.filesystem)'s description for that. You'll probably want to take a look at the stuff inside the module too.

After this, I'd say take a look at [`love.keyboard`](http://love2d.org/wiki/love.keyboard) for taking keyboard input, [`love.mouse`](http://love2d.org/wiki/love.mouse) for mouse input, and [`love.audio`](http://love2d.org/wiki/love.audio) for dealing with playing audio.

That covers your essential modules. After this, take a look at the other modules if you need some more advanced functionality. For example, if you need physics, you may want to use [`love.physics`](http://love2d.org/wiki/love.physics).

In summary:

* [`love.graphics`](http://love2d.org/wiki/love.graphics)
* [`love.filesystem`](http://love2d.org/wiki/love.filesystem)
* [`love.keyboard`](http://love2d.org/wiki/love.keyboard), [`love.mouse`](http://love2d.org/wiki/love.mouse), and [`love.audio`](http://love2d.org/wiki/love.audio)
* Explore the rest!

### Object-Oriented Programming

(Note that you don't have to understand OOP to get started with LÖVE, but a bit of knowledge of it will help you down the track.)

OOP is a programming paradigm which is based around the need to associate data with functions (also called methods) which manipulate that data. There are a lot of concepts that go into OOP, so I'll only explain the basics here. The most common way (used by LÖVE) of implementing OOP is by using classes and objects. Classes are like a blueprint for creating a certain type of object. Classes define the varying data that each instance of the class (objects) will hold, and the methods that are available to manipulate that data.

Classes are used to create objects; so it's like using the blueprint to create an instance of thing that it depicts. This means that objects have their own set of data which can be manipulated, and methods defined by the class which do something with that data.

I know this is all very abstract, but here's an example straight from LÖVE:

{% highlight lua %}
-- love.graphics.newParticleSystem creates an instance of the ParticleSystem class
-- The ps variable now contains an object of the ParticleSystem class
ps = love.graphics.newParticleSystem(image, 1000)
ps:getDirection() -- getting some data that the object holds
ps:setDirection(0) -- setting some data of the object
ps:start() -- calling a method which uses the data to do something
{% endhighlight %}

If you want to learn more about OOP, do some research on it on the web; the [wikipedia article](http://en.wikipedia.org/wiki/Object-oriented_programming) on it may help. I also recommend reading the introductory material to this [NetTuts+ tutorial](http://net.tutsplus.com/tutorials/php/object-oriented-php-for-beginners/); the rest is about PHP, but the start has some good material on the core concepts of OOP.

## The Community

LÖVE's community is one of its many strong points. The community is very helpful, friendly, and usually quick to respond. If you ever get stuck, make sure you head over to the [forums](http://love2d.org/forums) and ask for help in the [Support and Development area](http://love2d.org/forums/viewforum.php?f=4) (be sure to read the [rules](http://love2d.org/forums/viewtopic.php?f=4&t=2982) first!). There's an IRC channel too, located at [#love@irc.freenode.net](http://webchat.freenode.net/?channels=love&uio=d4); it usually has a good amount of people there.

## Conclusion

Well, thanks a lot for reading. I hope this has helped you in some way. As said before, if you have any feedback be sure to leave me a [comment](#respond).

Have fun!
