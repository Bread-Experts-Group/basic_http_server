#!/bin/bash
./buildAda.sh $1 && sudo bin/$1/basic_http_server-native ${@:2}