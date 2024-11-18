#!/bin/bash
mkdir -p bin/$1;
./buildAda.sh $1;

alr build --profiles=*=$1 -- --target=x86_64-windows -o $1/basic_http_server-x86-windows.exe -Xbinder="" -Xlinker="" -cargs -march=native;
alr build --profiles=*=$1 -- --target=aarch64-linux -o $1/basic_http_server-aarch64-linux -Xbinder="" -Xlinker="";

alr exec -- gnatclean -Pbasic_http_server.gpr;

alr build --profiles=*=$1 -- --target=x86_64-windows -o $1/basic_http_server-x86-windows-shared.exe -Xbinder="-shared" -Xlinker="-s" -cargs -march=native;
alr build --profiles=*=$1 -- --target=aarch64-linux -o $1/basic_http_server-aarch64-linux-shared -Xbinder="-shared" -Xlinker="-s";