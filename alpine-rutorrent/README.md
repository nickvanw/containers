rutorrent
=========

This is an opinionated and minimal `rutorrent` container that is designed to attach to an rtorrent instance running with my `alpine-rtorrent` container. I doubtit will work without a _lot_ of work for anyone else, so I honestly wouldn't bother.

I made it because I found all of the other rutorrent containers were either all-in-one rtorrent+rutorrent+other crap, or didn't work with the way I wanted to set things up. 


## Setup

This container should set itself up - mount the rtorrent volume or folder that you have for rtorrent in `/data` and let it boot up. 

## Running

Because of the way my network is set up, there is no auth for any part of this container. If you run it facing the public internet, anyone will be able to execute arbitrary commands on your server because of the way `rtorrent`'s XML-RPC works. don't do that, put it behind a load balancer please.

Because it's running in a different container than rtorrent, a lot of the plugins that come with rutorrent won't work - they require being able to execute stuff via XML-RPC in rtorrent. This is by design - the Dockerfile will remove all of the plugins that require that, which keeps it nice and clean. 
