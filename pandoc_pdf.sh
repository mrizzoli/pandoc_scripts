##Pandoc md to pdf with biblio

#!/bin/bash
echo "controllo la configurazione.."
. /home/marco/pandoc_scripts/pandoc_config.sh
echo "...ok"
#pulizia

echo "faccio pulizia"
if [ -f "${header}" ];
  then
    rm "${header}"
    echo "rimosso "${header}
fi

if [ -f "${nocite}" ];
  then
    rm ${nocite}
    echo "rimosso "${nocite}
fi

if [ -d "${percorso}/${paper}" ];
  then
    rm -rf ${percorso}/${paper}
    echo "rimosso "${percorso}/${paper}
fi
echo "...ok"

#prepara header
echo "preparo l'header"
printf "%s"---"\n%sauthor: ""${author}""\n%stitle: "${title}"\n%sdate: "${data}"\n%sbibliography: biblio.bib\n%sgeometry: margin=2.5cm\n%s"---"\n" > ${header}
echo "...ok"
#prepara cartella e files necessari
echo "preparo la cartella di lavoro in " ${percorso}/${paper}
mkdir ${percorso}/${paper}
cat ${header} ${paper} > ${percorso}/${paper}/main.md

cp ${basefiles}/biblio.bib ${percorso}/${paper}/biblio.bib
cd ${percorso}/${paper}
echo "...ok"
#compila pdf
echo "inizio la compilazione del pdf"
#pandoc -S -s -o main.pdf --latex-engine=xelatex main.md
pandoc -S -s -o main.docx -t docx main.md
echo "fatto, trovi tutto in " ${percorso}/${paper}
