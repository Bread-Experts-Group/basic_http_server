#!/bin/bash
mkdir -p bin/$1;
alr exec -- gnatpp -Pbasic_http_server.gpr --max-line-length=179 --wide-character-encoding=8 --eol=lf -k --layout=tall -U;

alr build --profiles=*=$1 -- -o $1/basic_http_server-native-linux -Xbinder="" -Xlinker="" -cargs -march=native;

alr exec -- gnatclean -Pbasic_http_server.gpr;

alr build --profiles=*=$1 -- -o $1/basic_http_server-native-linux-shared -Xbinder="-shared" -Xlinker="-s" -cargs "-march=native";