---
layout: post
title: "Weight Tracking - Part 2"
date: 2009-05-23
modified: 2009-05-15
category: "Inside the Engineer, Ruby"
author: "Jonathan Creekmore"
email: "jonathan@thecreekmores.org"
---

So, in writing the previous post on my [Weight Tracking
spreadsheet](http://thecreekmores.org/2009/05/16/weight-tracking), I came upon
a bit of a conundrum. I wanted to export my graph as an image, but I could not
figure out how to do that in Numbers. I am sure that there is a way to do so,
but it was not immediately obvious, even with a brief Google search. So, being
a good engineer, I decided to roll my own weight tracking script. Writing my
own script has several advantages. First, writing my own script gave me a
simple project to begin learning [Ruby](http://www.ruby-lang.org/), something
I have been wanting to do. Second, it allows me to extend the script with
functionality that might be clumsy in a spreadsheet. Right now, I am just
keeping track of the same information that I did in the spreadsheet, dates and
weights, only I track it in a simple text file. The script calculates the
sliding average for me. If needed, I can easily munge the data in other ways
or pull together a secondary text file with other information like my workout
routine. I know that I could do the same thing in a spreadsheet, but I like
the flexibility that a full programming language gives me over the comparative
restraint that I feel when I am hacking together formulas in a spreadsheet.
Additionally, my data is kept in a simple text file instead of being tied to a
Numbers spreadsheet. Finally, and most importantly, I was easily able to pull
in a library that allowed me to plot my weight and the sliding average of my
weight over time and export it as an image file. ![Weight vs.
Time](http://thecreekmores.org/wordpress/wp-
content/uploads/2009/05/weight-300x225.png) There are two obvious improvements
that I will likely implement. First, I am calculating the sliding window
average of my weight as an integer. That is what causes the strange steps on
the graph. I will probably change to calculating the average as a real number,
just to make the graph a little smoother. Second, I think that I want to have
more points on the X-axis of the graph. Looking at it, I think that the first
of each month should be marked on the graph, possibly with lines of
demarcation running in the Y-direction at each monthly border. I will have to
play around with it and see what all I can do with the graphing library. That
is the great thing about being a programmer; if the software you are using
does not do what you want it to do, you can either fix it or write your own
version.

  *[CotM]: Children of the Mind
  *[NW]: Night Watch
  *[TDitCoS]: To Dream in the City of Sorrows
  *[NES]: Nintendo Entertainment System
  *[N64]: Nintendo 64
  *[GC]: GameCube
  *[SNES]: Super Nintendo Entertainment System

