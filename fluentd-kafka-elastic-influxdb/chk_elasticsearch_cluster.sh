#!/bin/bash

curl -s -XGET http://localhost:9200/_cat/nodes?v
curl -s -XGET http://localhost:9200/_cat/master?v
curl -s -XGET http://localhost:9200/_cat/allocation?v

