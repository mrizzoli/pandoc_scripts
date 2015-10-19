#!/bin/bash
echo "controllo la configurazione.."
. /home/marco/scripts/pandoc_config.sh
echo "...ok"


mkdir -p /tmp/tesi
rm /tmp/tesi/tesi.md

echo "preparo l'header"
printf "%s"---"\n%sauthor: ""${author}""\n%stitle: ""${title}""\n%sdate: "${data}"\n%sbibliography: ""${biblio}""\n%sgeometry: ""${geometry}""\n%sfontsize: ""${dimensioni}\n" > /tmp/tesi/tesi.md
echo "---" >> /tmp/tesi/tesi.md

cd /home/marco/Downloads/tesi/markdown/Capitoli
for file in Chapter*
do
  cat $file >> /tmp/tesi/tesi.md
done

cat note.md >> /tmp/tesi/tesi.md

pandoc -S -s /tmp/tesi/tesi.md -o /home/marco/Downloads/tesi.docx
