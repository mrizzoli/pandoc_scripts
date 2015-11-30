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

# #newname=${dest}/"tesi_"$(date +%F_%T)".pdf"
# #export newname

# #mv ${dest}/template_tesi.pdf ${newname}

#wget -O template_tesi.pdf https://www.dropbox.com/s/gtjeuz4hlkxxwa9/template_tesi.pdf?dl=0

wget -O send_mail.py https://raw.githubusercontent.com/mrizzoli/pandoc_scripts/master/send_mail.py
python send_mail.py

wget -O send_file.py https://raw.githubusercontent.com/mrizzoli/pandoc_scripts/master/send_file.py
python send_file.py

rm -rf ${dest}
