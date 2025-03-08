---
layout: post
title: "Abstractions"
date: 2005-07-11
modified: 2005-07-11
category: "General Crankiness"
author: "Jonathan Creekmore"
email: "jonathan@thecreekmores.org"
---

As a software developer, working with abstractions is a part of my daily life.
When I am reading a section of code and I see that a particular class exposes
the interface for a Factory, I know what that class is supposed to be used
for, because I know what a Factory is used for (namely, making things).
Likewise, when I am designing a section of code, if I know that the purpose of
the code is to make something, I will expose the interface for a Factory
because that allows other developers to read my code and know what the code is
supposed to do. Making software more readable and easier to reason about is
one of the purposes of software abstractions. In general, when designing a
software subsystem, one should choose the simplest possible abstraction that
will get across the point. Obviously, the abstraction cannot be any simpler
than that or it will not communicate the intent of the subsystem. However,
making the abstraction _as simple as necessary_ can be difficult. Is the
abstraction simple enough or does it contain unneeded complexity? What is the
point of all of this? While working on the design of a new subsystem, I
encountered a place where a particular abstraction would be perfect. The
interface for the abstraction was already designed and it was in use in
several parts of the system, so it should be readily apparent to others
reading my code what it is my subsystem does. Imagine my dismay when the nice,
simple, clean abstraction that I remembered no longer bore any resemblance to
the nice, simple, ideal. Over the years, more and more cruft had been added
into the simple interface that is unnecessary for the problem at hand. Instead
of having an interface Foo, I now have an interface FooWithWidgetAndFactory.
So, I am torn between two alternatives:

  1. Split apart the existing interface into the original, simple abstraction and a new abstraction that extends the simple one (and contains all of the cruft that has been added
  2. Implement the existing interface as is and deal with the fact that I will have to implement several methods that will not do anything except confuse the poor user of my subsystem in the future.

Unfortunately, while alternative #1 is the best approach, it is also the most
time-consuming and unrealistic of the two (probably several man-weeks).
Ironically, if that approach had been taken the very first time this problem
cropped up, I probably would not be in the situation of having to choose
between the two (since everyone after the first person would have mimicked the
first person). So, I suppose I will have to get over trying to do the right
thing and choose #2, even though I do not like it. Still wondering what the
point is? I did not sleep last night and am cranky and this just irked me
enough into posting about it.

