---
layout: post
title: "Breaking the Build"
date: 2012-09-29
modified: 2012-09-29
category: "General Nerdiness, Books"
author: "Jonathan Creekmore"
email: "jonathan@thecreekmores.org"
---

For work, I am reading a book called [Continuous
Delivery](http://www.amazon.com/Continuous-Delivery-Deployment-Automation-
Addison-Wesley/dp/0321601912/ "Continuous Delivery"). Its tagline is
"_Reliable Software Releases through Build, Test, and Deployment Automation._
" I am reading it so that I can apply its principles both for software
projects at work and software projects at home. Lately, I have been seeing
ways that I can apply it in real life. For instance, the book has a chapter on
Continuous Integration, of which there exists a companion book as well as
numerous other texts on the subject. The first role of Continuous Integration
is "Thou shalt not break the build." For every change that is made, there
should be tests that make sure that a regression has not occurred. How can I
apply this rule in real life, though?

Last week, I had worked enough hours that I came home and decided to finally
deal with the mess that was my dresser and closet. Both were overflowing; I
didn't wear most of it and, when input my clothes up, I just crammed them
wherever I could, regardless of where they went or whether there was room to
put them where they were being shoved. So, I took out every piece of clothing
I owned, touched them all, and determined whether I wanted to keep them, given
them away, or just get rid of them. It took two hours, but I finally got the
mess under control. Now, to apply Continuous Integration to this problem, I
need to define some tests that I check every day.

Here are the tests I came up with, in the form of a check list:  

  * Ensure that the top of the dresser is clear
  * Ensure that the top of the cedar chest is clear
  * Ensure that there is adequate spacing between hanging clothes so I can see what is there
  * When opening drawers to remove clothes, ensure that the remaining clothes are neatly folded

These basic tests that I mentally check every time I go in our room or closet
have helped me, in the last week, make sure that the clean up I did last week
does not suffer a regression. If, like this morning, I discover something on
the dresser, I consider the build to be broken and revert the change (I
removed the offending article and worked to make sure that the problem was
fixed). Over time, I hope that incremental changes like this will help make
sure that the master bedroom and closet are neat and tidy. Then, I can tackle
the other rooms in the house. The keys to make sure that problems are taken
care of as soon as they occur, just like in Continuous Integration.



[![Posted with
Blogsy](http://blogsyapp.com/images/blogsy_footer_icon.png)Posted with
Blogsy](http://blogsyapp.com)

  *[CotM]: Children of the Mind
  *[NW]: Night Watch
  *[TDitCoS]: To Dream in the City of Sorrows
  *[NES]: Nintendo Entertainment System
  *[N64]: Nintendo 64
  *[GC]: GameCube
  *[SNES]: Super Nintendo Entertainment System

