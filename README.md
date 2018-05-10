Purad for Docker
===================

Docker image that runs the PURA purad node in a container for easy deployment.

Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/1HngXg0), [Digital Ocean](http://bit.ly/18AykdD), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 100 GB to store the block chain files (and always growing!)
* At least 1 GB RAM + 2 GB swap file

Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/puracore/docker-purad/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `purad-data` volume to persist the purad blockchain data, should exit immediately.  The `purad-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=purad-data
        docker run -v purad-data:/pura --name=purad-node -d \
            -p 44444:44444 \
            -p 127.0.0.1:44443:44443 \
            kylemanna/purad

2. Verify that the container is running and purad node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                                                   NAMES
        e8c1b7b39cb6        pura:latest         "pura_oneshot"           4 minutes ago       Up 4 seconds        127.0.0.1:44443->44443/tcp, 0.0.0.0:44444->44444/tcp, 55554-55555/tcp   purad-node


3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f purad-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).