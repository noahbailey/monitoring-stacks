FROM ruby:2.7-buster

# => Install GeoIP packages
RUN apt-get update && \
    apt-get install -y \
    libgeoip-dev \
    geoip-database \
    geoip-bin

# => Install fluentd + plugins
RUN gem install fluentd                         -v 1.11.2 && \
    gem install fluent-plugin-kafka             -v 0.15.1 && \
    gem install fluent-plugin-elasticsearch     -v 4.1.2  && \
    gem install fluent-plugin-influxdb-v2       -v 1.5.0  && \
    gem install fluent-plugin-secure-forward    -v 0.4.5  && \
    gem install fluent-plugin-geoip             -v 1.3.2

RUN mkdir /fluentd 

COPY fluentd.conf /fluentd/fluentd.conf

# => Run stage
ENTRYPOINT exec fluentd -c /fluentd/fluentd.conf
