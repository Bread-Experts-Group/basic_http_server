#!/bin/bash
./buildAda.sh $1; alr build --profiles=*=$1 -- --target=x86_64-windows -o basic_http_server-windows.exe; alr build --profiles=*=$1 -- --target=aarch64-linux -o basic_http_server-aarch64