FROM phusion/baseimage

MAINTAINER Kirill Kirikov kk@4irelabs.com

ARG USER_ID
ARG GROUP_ID

ENV HOME /pura

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} pura
RUN useradd -u ${USER_ID} -g pura -s /bin/bash -m -d /pura pura

RUN chown pura:pura -R /pura

ADD https://github.com/puracore/pura/releases/download/v1.0.0.0/PURA-1.0.0-DAWN-Linux-x64.tar.gz /tmp/
RUN tar -xvf /tmp/PURA-*.tar.gz -C /tmp/
RUN cp /tmp/pura*/bin/*  /usr/local/bin
RUN rm -rf /tmp/pura*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER pura

VOLUME ["/pura"]

EXPOSE 44444 44443 55555 55554

WORKDIR /pura

CMD ["pura_oneshot"]