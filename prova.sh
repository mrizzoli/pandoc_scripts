#!/bin/bash
cd /home/marco/Downloads/tesi/markdown/Capitoli
temporanea="/tmp/tesi"
for file in Chapter*
do
    echo "copio "$file" in "$temporanea""
    cat "$file" note.md >> ${temporanea}/$file
done
