FROM ruby:2.7-buster

# => Install GeoIP packages
RUN apt-get update && \
    apt-get install -y \
    libgeoip-dev \
    geoip-database \
    geoip-bin

# => Install fluentd + plugins
RUN gem install fluentd                         -v 1.12.3 && \
    gem install fluent-plugin-rabbitmq          -v 0.0.9  && \
    gem install fluent-plugin-secure-forward    -v 0.4.5  && \
    gem install fluent-plugin-geoip             -v 1.3.2

RUN mkdir /fluentd 

COPY fluentd.conf /fluentd/fluentd.conf

# => Run stage
ENTRYPOINT exec fluentd -c /fluentd/fluentd.conf
