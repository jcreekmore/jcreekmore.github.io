---
layout: post
title: "Apparent end of the email fiasco"
date: 2005-07-20
modified: 2005-07-21
category: "Joyous Events"
author: "Jonathan Creekmore"
email: "jonathan@thecreekmores.org"
---

Well, it appears that I have gotten my email problem straightened out again. I
need to do some more testing before I decided to turn back on automatic
downloading of all of my email onto my home system, but so far everything
seems to work ok. Here was what was happening. First, I had set knology as my
relay host, meaning that all of my email would go through them (necessary
since they block all outgoing email traffic unless it is going to their
server). However, they were not forwarding email on to addresses on other
hosts, like my parents' address. So, in trying to fix that problem, I got my
server configuration so messed up that the automatic downloading of all of my
email for most of a day just went away.... lost in the bit-bucket, as it were.
Finally, I came to the conclusion that knology would not forward on email if
it did not appear to come from an email address hosted on their servers, so I
had to set up some address translation to make my local address appear in the
email header to be from knology. Now they accept my email and send it on its
merry way. However, I still had the problem of fetchmail seeming to just
delete all of my email. Turns out that it was trying to forward it through
knology as well... which was not what I wanted. More configuration changes
showed that I had my mail host name set up incorrectly. It is fixed now and
mail appears to be moving normally. But, I think I will take more time to
test...

* * *

Update: Oops, I spoke too soon. In anticipation of Ashley using the home
server for her email, I placed the same address translation for her email
address as I did for mine. That caused the server to think that my emails for
her (which needed to be sent to knology for relaying) needed to be delivered
locally. The effect of that is that the emails I sent for Ashley started to
pile up in her account on the server, which she never checks. Luckily, that
was a relatively easy fix, compared to the rest of the problems I have had...

