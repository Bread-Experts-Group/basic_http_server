#!/bin/bash
alr exec -- gnatpp -Pbasic_http_server.gpr --max-line-length=179 --wide-character-encoding=8 --eol=lf -k --layout=tall -U; alr build --profiles=*=$1 -- -o basic_http_server-native