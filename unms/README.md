## UNMS

This is a very rough cut of an all-in-one container for the Unifi `unms` app. As it's currently distributed, it's largely impossible to actually deploy on anything but a dedicated VM. This uses a bit of reverse engineering and some help from others that have done this to figure out the dependencies for the app, and tries to be as slim as possible. That means no `nginx` in front of Node, no `fluentd` for logs, and no `letsencrypt` for TLS. 

Because the UNMS source isn't actually distributed, you'll have to figure out how to get it - it's located in `/home/app/unms` in the `unbnt/unms` image - currently this is building against 0.12.2.


### Setup

This container will want to expose two ports (which should probably be noted in the `Dockerfile`): 8081 and 8082. 8081 has the Web UI and 8082 the websocket connection for other Edge* devices to contact UNMS. 

Using `traefik`, I've just mapped those two two different virtual hosts, which allows me access to both without an issue. 

PRs are welcome, and I'll try to clean this up as time goes along, as well as maybe make sure it build against the latest. 


### Warning

Proceed at your own peril, this is a poorly written `Dockerfile` that runs software that's not meant to be run this way, nobody knows what you'll run in to. 

