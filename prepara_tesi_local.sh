#!/bin/bash

## Setta variabili e percorsi

origine="/home/marco/Downloads/tesi/markdown/Capitoli"
temporanea="/tmp/tesi"
dest="/home/marco/Downloads/tesi/latex/Chapters"

##concatena file md con note, uno per uno
rm ${dest}/*
rm ${temporanea}/*
mkdir -p ${temporanea}

cd ${origine}

for file in Chapter*
do
    echo "copio "$file" in "$temporanea""
    cat "$file" note.md >> ${temporanea}/$file
done

##esporta in latex

cd ${temporanea}

for file in *
do
    echo "esporto in latex "$file""
    pandoc --biblatex --chapters -o ${dest}/$file.tex $file
done

##cambia dir in /tesi/latex

cd ${dest}

for file in *
do
    mv $file ${file%%.*}.tex
done

##xelatex

cd /home/marco/Downloads/tesi/latex
xelatex template_tesi.tex

