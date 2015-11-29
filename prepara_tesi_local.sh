#!/bin/bash
set -e  # Fail on errors
set -x  # Verbosity all the way

## Setta variabili e percorsi
dest="/tmp/tesi_wd"

git clone https://github.com/mrizzoli/tesi.git ${dest}
mkdir -p ${dest}/Chapters
cd ${dest}


##concatena file md con note, uno per uno

for file in Capitolo*
do
    echo "copio "$file" in "$dest"/Chapters"
    cat "$file" note.md >> ${dest}/Chapters/$file
done

##esporta in latex

cd ${dest}/Chapters

for file in *
do
    echo "esporto in latex "$file""
    pandoc --biblatex --chapters  -o $file.tex $file 
done

##cambia dir in /tesi/latex
rm *.md

for file in *
do
    mv $file ${file%%.*}.tex
done

##xelatex

cd ${dest}
xelatex template_tesi.tex
biber template_tesi
xelatex template_tesi.tex

mv ${dest}/template_tesi.pdf ~/Documents/tesi_"$(date +%F_%T)".pdf

rm -rf ${dest}
