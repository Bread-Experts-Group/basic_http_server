#!/bin/bash
mkdir -p bin/$1;
./buildAda.sh $1;

rm -rf obj
# alr build --profiles=*=$1 -- --target=x86_64-w64-mingw32 -o $1/basic_http_server-x86_64-windows.exe -Xbinder="" -Xlinker="" -cargs -march=native;
alr build --profiles=*=$1 -- --target=aarch64-linux -o $1/basic_http_server-aarch64 -Xbinder="" -Xlinker="";

alr exec -- gnatclean -Pbasic_http_server.gpr;

rm -rf obj
# alr build --profiles=*=$1 -- --target=x86_64-w64-mingw32 -o $1/basic_http_server-x86_64-windows-shared.exe -Xbinder="-shared" -Xlinker="-s" -cargs -march=native;
alr build --profiles=*=$1 -- --target=aarch64-linux -o $1/basic_http_server-aarch64-shared -Xbinder="-shared" -Xlinker="-s";