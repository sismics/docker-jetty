#
# Dockerfile for Debian + Jetty Web Server

FROM sismics/debian-java:8.102.1
MAINTAINER Jean-Marc Tremeaux <jm.tremeaux@sismics.com>

# Download and install Jetty
ENV DEBIAN_FRONTEND noninteractive
ENV JETTY_VERSION 9.3.11.v20160721
RUN wget -nv -O /tmp/jetty.tar.gz \
    "http://eclipse.org/downloads/download.php?file=/jetty/${JETTY_VERSION}/dist/jetty-distribution-${JETTY_VERSION}.tar.gz&r=1" \
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
