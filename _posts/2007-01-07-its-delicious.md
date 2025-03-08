---
layout: post
title: "It's Delicious"
date: 2007-01-07
modified: 2007-01-07
category: "Books, Home Projects"
author: "Jonathan Creekmore"
email: "jonathan@thecreekmores.org"
---

Much like [Misty](http://granades.com/2007/01/06/cataloging-the-granade-
library-part-6/), I started cataloging all of Ashley and my books into
[Delicious Library](http://www.delicious-monster.com/). So far, I have
processed the bookshelf in our dining room. Here is the breakdown so far:  
  
  * 170 books scanned.
  * 95 books are mine.
  * 75 books are Ashley's.

Today, I did not care to start scanning books again -- that is an arduous
task. Perhaps later tonight I will start on our bedroom. Instead, I started
playing around with the export capabilities of Delicious Library with the
ultimate goal of getting our library linked as a page off of the site.
Basically, Delicious Library exports the entire library as a tab-separated
file with the field names as the first line and each following line containing
the information for one scanned in item. While that file could be linked off
of the site, it would not be very pretty. So, I wrote a small python script to
munge the data into XML so that an XSL file could generate a web page from the
data. That is working fairly well so far. I have also found that Delicious
Library stores all of its data as XML. So, I am considering just writing some
code to transform that file into one containing only the data I am interested
in. Either way, expect a new link off of the sidebar soon containing our
library contents.

  *[CotM]: Children of the Mind
  *[NW]: Night Watch
  *[TDitCoS]: To Dream in the City of Sorrows
  *[NES]: Nintendo Entertainment System
  *[N64]: Nintendo 64
  *[GC]: GameCube
  *[SNES]: Super Nintendo Entertainment System

