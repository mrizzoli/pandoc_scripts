#!bin/bash

cd /home/marco/Downloads/tesi/markdown

pandoc -S -s -t odt -f markdown --bibliography=/home/marco/Downloads/tesi/latex/benenati.bib -o tesi.odt
