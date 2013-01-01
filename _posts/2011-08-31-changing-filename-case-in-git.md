---
layout: post
title: Changing Filename Case in Git
date: 2011-08-31 14:21:28
category: Tutorials
tags:
  - Git
  - quick tips
---

**UPDATE**: A much easier way is to use `git mv -f readme.txt README.txt`. Thanks to "Gurpartap Singh" for pointing that out in the comments section.

I thought I'd share a quick little trick I've learned for changing the case of a filename in Git. Git is (unfortunately) case-insensitive with filenames. Therefore, if you make a change to a filename's case without using `git mv`, it won't be picked up. If you do try to use `git mv` (for example, `git mv file File`), Git won't accept it, as it doesn't detect any change.

Say we have a file named `readme.txt`, and we want to rename it to `README.txt`. The first step is to rename it to something else; I usually just add a dash to the name, so I'd execute `git mv readme.txt readme.txt-`. Then rename it to what you originally wanted: `git mv readme.txt- README.txt`. Git will have now picked up the change, and it will be present in the next commit. That's there is to it.
