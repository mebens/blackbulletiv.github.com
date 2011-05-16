---
layout: post
title: 5 Generic Rules for Clean Code
category: General
tags:
  - English
  - programming
---

I've been mulling over a few generic rules for a clean code style, and I though I'd share. These are very generic, as in, they don't give any specifics like two-space indentation or something. These rules are the things I've learned in my time coding, and they help me a lot to keep my code looking clean.

Clean code is like proper English with good formatting, when compared with sloppy English. Sloppy English is faster to write, but a lot harder to read, and harder to maintain. It's the same way with code. So take a few more key strokes for readability and easy maintenance.

Anyway, without further ado, here they are:

#### 1. Be consistent in everything, except inconsistency itself.

Code with a style that's inconsistent is hard to read. It's like English with an inconsistent writing style, use of whitespace, spelling, and punctuation.

#### 2. Keep your rules few and simple.

Your code can start to look inconsistent if you make a tonne of style rules. For example, if I had rules like this:

> Put whitespace inside parenthesis if the method name is more than 15 characters long, or the line is more than 70 characters long; otherwise don't.
> Use curly braces on one line blocks if the current indentation level is less than 5.

In the actual code things would look inconsistent. Remember, the only people see is your code.

#### 3. Always, always indent properly.

No indentation is just plain ugly to look at. It will make your code _much_ harder to read, and will cause problems for you when finding bugs.

#### 4. Put whitespace to good use.

You don't have to avoid whitespace like the plague. Use blank lines to separate sections of code, like paragraphs in English. Reading code without blank lines is like reading a big lot of English without paragraphs, it's pretty tough.

#### 5. Split up code.

Don't put all your code in one long function, or one long file. Split it up into meaningful sections, like functions, classes, files, comment headers, etc. It makes it easier to navigate the code base (as chapters and sections in a book make it easier to navigate).

