# Monitoring Stacks

This repo contains some POC/Experimental monitoring solutions to help me decide on _The Ultimate System_. 

The basic requirements: 

1. Must _feel_ good to use. It should be 'Unixey' and simple to follow. 
2. Must be very stable. I don't want to spend all day worrying about dumb problems with my monitoring system. It has to be _more stable_ than the apps it monitors. 
3. Data formats: 

  * Suricata `eve.json` logs
  * OSSEC `alerts.json` logs
  * Syslogs; or `journald` integration
  * auditd parsing
  * httpd (apache/nginx) access/error logs
  * Metrics - Statsd or Fluentd, or sysstat

4. In addition, it should be able to add some basic metadata

  * GeoIP (maxmind geolite2)
  * Threat intel feeds (?)
  * Source/dest lookups

5. While most of the data will be unstructured logs, I hope to parse & store common data types and fields. 
6. As logs are time-series data, date parsing (from UTC) should always produce an accurate timestamp
7. Data should be archivable, ideally in plaintext format that is 'greppable'
8. Data should also be alertable, and usable to produce reports or perform security analysis. 

And, most of all, it should be __durable__. Each stage of the pipeline should have the ability to store and retry failed submissions, and there shouldn't be any situation where logs or metrics get dropped. A brief outage should be possible at any point without the loss of timeseries data. While some teams opt for a highly-available system with loadbalancers and highly replicated databases, this should run on a system with plenty of points of failure. 

## Prototypes

A few prototypes are being built: 

1. Elasticsearch + Fluentd
2. Apache Solr + Fluentd
3. Elasticsearch + Logstash
4. Collectd + Fluentd/Fluentbit + InfluxDB

Some additional systems are being considered as well: 

1. Postgresql + Fluentd
2. Timescaledb + Fluentd/fluentbit

## Links & Resources

* https://github.com/influxdata/influxdb-plugin-fluent
* https://github.com/haruyama/fluent-plugin-out-solr
* https://www.influxdata.com/products/influxdb-overview/influxdb-2-0/
