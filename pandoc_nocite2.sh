##Pandoc md to pdf with biblio --nocite

#!/bin/bash

echo "controllo la configurazione.."
. /home/marco/scripts/pandoc_config.sh
echo "..."

#prepara header
echo "preparo l'header"
printf "%s"---"\n%sauthor: ""${author}""\n%stitle: ""${title}""\n%sdate: "${data}"\n%sbibliography: ""${biblio}""\n%sgeometry: ""${geometry}""\n%sfontsize: ""${dimensioni}\n" > ${percorso}/wp.md
echo "...ok"

#prepara file biblio per md nocite
echo "piccolo ciappo sulla bibliografia per usare nocite.."
cat $biblio | grep @ > ${nocite}.tmp
sed -i 's/@.*{/@/g' ${nocite}.tmp
sed -i ':a;N;$!ba;s/\n/ /g' ${nocite}.tmp
printf "%snocite: |\n\t" >> ${percorso}/wp.md
cat ${nocite}.tmp >> ${percorso}/wp.md
echo "---" >> ${percorso}/wp.md
echo "...ok"

cat ${paper} >> ${percorso}/wp.md

#prepara cartella e files necessari
#echo "preparo la cartella di lavoro in " ${percorso}/
#cat ${header} ${nocite} ${paper} > ${percorso}/${paper}

#cp ${basefiles}/biblio.bib ${percorso}/${paper}/biblio.bib

cd ${percorso}/
echo "...ok"

#compila pdf
echo "inizio la compilazione del pdf"
pandoc -S -o main.pdf --filter pandoc-citeproc --latex-engine=xelatex wp.md
#pandoc -S -o main.docx --filter pandoc-citeproc -t docx main.md

echo "fatto, trovi tutto in " ${percorso}/
evince ${percorso}/main.pdf
