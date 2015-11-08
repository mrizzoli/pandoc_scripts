#!/bin/bash

cd ~/Downloads/notes_stuff/drafts
for file in *.odt
do
    echo "esporto in latex "$file""
    pandoc -f odt -t markdown -o $file.md $file
done
