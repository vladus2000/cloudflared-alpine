FROM vladus2000/alpine-base
MAINTAINER vladus2000 <docker@matt.land>

COPY shiz/ /

ENV STARTUP_CMD="/cloudflared proxy-dns --port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query --address 0.0.0.0"

RUN \
        /update.sh && \
        apk add --no-cache libc6-compat ca-certificates && \
	wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz && \
	tar xvfz cloudflared-stable-linux-amd64.tgz && \
	rm -f cloudflared-stable-linux-amd64.tgz

USER nobody:users

EXPOSE 5053/tcp 5053/udp

CMD /bin/ash -c /startup.sh

