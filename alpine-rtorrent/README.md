rtorrent
=======

This is a minimal rtorrent container based on alpine and s6 init. It won't work without some configuration, and assumes some defaults.

## Setup

The container assumes that you have a named volume or folder on your Docker host that can be mounted at `/data`. I used a named volume:

```
docker volume create rtorrent
```

to ensure that our data sticks around. Inside of that volume, you'll need to add the following:

* `/data/downloads` and `/data/session` folders
* `/data/rtorrent.rc` to configure rtorrent - there's an example config in this folder.

The container will automatically 'fix' permissions, so I just go in and mount the directory with another container:

```
docker run -ti --rm -v rtorrent:/data ubuntu bash
```

and add all of the files and folders that are needed.

## Running

Assuming you're using the same config that I am, just run the container with that named volume or directory and expose port `63256`.

It will boot up `rtorrent` managed by `dtach`, which is cool because you can use `dtach` from outside of the container to take a look at rtorrent if you want. 
