#!/bin/bash
./buildAda.sh $1 && sudo bin/basic_http_server-native-$1 ${@:2}