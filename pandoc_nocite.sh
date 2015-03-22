##Pandoc md to pdf with biblio --nocite

#!/bin/bash

echo "controllo la configurazione.."
. /home/marco/scripts/pandoc_config.sh
echo "...ok"

#pulizia

echo "faccio pulizia"
if [ -f "${header}" ];
  then
    rm "${header}"
    echo "rimosso "${header}
else
  echo ${header} "non trovato, sicuro che vada tutto bene?"

fi

if [ -f "${nocite}" ];
  then
    rm ${nocite}
    echo "rimosso "${nocite}
fi

if [ -f "${percorso}/${paper}" ];
  then
    rm ${percorso}/${paper}
    echo "rimosso "${percorso}/${paper}
fi
echo "...ok"

#prepara file biblio per md nocite
echo "piccolo ciappo sulla bibliografia per usare nocite.."
cat $biblio | grep @ > ${nocite}.tmp
sed -i 's/@.*{/@/g' ${nocite}.tmp
sed -i ':a;N;$!ba;s/\n/ /g' ${nocite}.tmp
printf "%snocite: |\n\t" > ${nocite}
cat ${nocite}.tmp >> ${nocite}
echo "---" >> ${nocite}
echo "...ok"

#prepara header
echo "preparo l'header"
printf "%s"---"\n%sauthor: ""${author}""\n%stitle: ""${title}""\n%sdate: "${data}"\n%sbibliography: ""${biblio}""\n%sgeometry: ""${geometry}""\n%sfontsize: ""${dimensioni}\n" > ${header}
echo "...ok"

#prepara cartella e files necessari
echo "preparo la cartella di lavoro in " ${percorso}/
cat ${header} ${nocite} ${paper} > ${percorso}/${paper}.md

#cp ${basefiles}/biblio.bib ${percorso}/${paper}/biblio.bib

cd ${percorso}/
echo "...ok"

#compila pdf
echo "inizio la compilazione del pdf"
pandoc -S -o main.pdf --filter pandoc-citeproc --latex-engine=xelatex ${paper}.md
#pandoc -S -o main.docx --filter pandoc-citeproc -t docx main.md

echo "fatto, trovi tutto in " ${percorso}/${paper}
