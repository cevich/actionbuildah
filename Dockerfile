FROM fedora:latest
MAINTAINER Chris Evich <cevich@redhat.com>
ENV CONTAINER=true
RUN dnf update -y && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    mkdir -p /root/bin
ADD ["/setup.sh", "/entrypoint.sh", "/root/bin/"]
ADD ["/Dockerfile", "/packages.txt", "/root/"]
RUN /usr/bin/env DOCKERFILE=true \
        /usr/bin/bash /root/bin/setup.sh /root/packages.txt |& tee /root/setup.log && \
    chmod +x /root/bin/entrypoint.sh
ENTRYPOINT ["/root/bin/entrypoint.sh"]
