PROJECT=${2:-${PWD##*/}}
gnatpp -P$PROJECT.gpr --max-line-length=179 --wide-character-encoding=8 --eol=lf -k --layout=tall -U; alr build --profiles=*=$1; sudo bin/$PROJECT
