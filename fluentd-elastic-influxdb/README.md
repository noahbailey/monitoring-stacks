## Fluentd TLS config

Create a keypair in the `./fluentd/keys` subdirectory: 

     openssl req -new -x509 -sha256 -days 10000 -newkey rsa:2048 -keyout fluentd.key -out fluentd.crt

After the server is configured, it can be tested using openssl: 

    echo -e '\x93\xa9debug.tls\xceZr\xbc1\x81\xa3foo\xa3bar' | \
  openssl s_client -connect localhost:25225


## Fluentbit TLS Config

Since the agent is using TLS, it is not required to have a copy of the certificates. Simply reconfigure to use TLS: 

```ini
[OUTPUT]
    Name        forward
    Match       *
    Host        192.168.122.1
    Port        25225
    tls         on
    tls.verify  off
```