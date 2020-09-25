#!/bin/bash

curl -s -XGET http://localhost:8000/v3/kafka/local/topic | jq

