# Client Monitoring Setup


## Suricata

Install Suricata on the system: 

```
sudo apt-add-repository ppa:oisf/suricata-stable
sudo apt-get update
sudo apt-get install -y suricata suricata-update
```

Update the rules: 

```
sudo suricata-update && kill -USR2 $(pidof suricata)
```

Add an autoupdate script to `/etc/cron.d/suricata-update`

```
MAILTO=""
00 12 * * *  root /usr/bin/suricata-update --quiet --reload-command='/usr/bin/suricatasc -c ruleset-reload-nonblocking' >> /dev/null
```

## Auditd

```
sudo apt install auditd
```

Defaults will be ok, but a STIG can also be loaded if required. 

## Ossec

Install from source: 

```
sudo apt install gcc make libevent-dev zlib1g-dev  libssl-dev libpcre2-dev wget tar -y

wget https://github.com/ossec/ossec-hids/archive/3.6.0.tar.gz
tar xzf 3.6.0.tar.gz
cd ./ossec-hids-3.6.0

sudo ./install.sh
```


## Collectd

Install collectd on the system

```
sudo apt install -y collectd-core
```

Very basic config: 

```
BaseDir "/var/lib/collectd"
PIDFile "/run/collectd.pid"
Interval 10.0

LoadPlugin cpu
LoadPlugin load
LoadPlugin network

<Plugin network>
  Server "127.0.0.1" "25826"
</Plugin>


<LoadPlugin df>
  Interval 3600
</LoadPlugin>
<Plugin df>
  ValuesPercentage true
</Plugin>

```


## Fluentbit

Add the repository to `/etc/apt/sources.list.d/fluentbit.list`

```
deb https://packages.fluentbit.io/ubuntu/focal focal main
```

Install the package: 

```
sudo apt install td-agent-bit
```

# Configure

Sample config files are located in the `./collectd` and `./td-agent-bit` subdirectories. 
