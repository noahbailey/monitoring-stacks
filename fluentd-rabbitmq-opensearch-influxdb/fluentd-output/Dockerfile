FROM ruby:2.7-buster

# => Install fluentd + plugins
RUN gem install fluentd                         -v 1.12.3 && \
    gem install fluent-plugin-rabbitmq          -v 0.0.9  && \
    gem install elasticsearch-api               -v 7.13.3 && \
    gem install elasticsearch-transport         -v 7.13.3 && \
    gem install elasticsearch                   -v 7.13.3 && \
    gem install fluent-plugin-elasticsearch     -v 5.1.0  && \
    gem install fluent-plugin-influxdb-v2       -v 1.5.0

RUN mkdir /fluentd 

COPY fluentd.conf /fluentd/fluentd.conf

# => Run stage
ENTRYPOINT exec fluentd -c /fluentd/fluentd.conf
