#
# Dockerfile for Debian + Jetty Web Server

FROM sismics/debian-java:7.79.1
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Download and install Jetty
ENV DEBIAN_FRONTEND noninteractive
ENV JETTY_VERSION 9.2.20.v20161216
RUN wget -nv -O /tmp/jetty.tar.gz \
    "http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${JETTY_VERSION}/jetty-distribution-${JETTY_VERSION}.tar.gz" \
    && tar xzf /tmp/jetty.tar.gz -C /opt \
    && mv /opt/jetty* /opt/jetty \
    && useradd jetty -U -s /bin/false \
    && chown -R jetty:jetty /opt/jetty
WORKDIR /opt/jetty
RUN chmod +x bin/jetty.sh

# Init configuration
COPY opt /opt
EXPOSE 8080
ENV JETTY_HOME /opt/jetty
ENV JAVA_OPTIONS -Xmx512m

# Set the default command to run when starting the container
CMD ["bin/jetty.sh", "run"]
