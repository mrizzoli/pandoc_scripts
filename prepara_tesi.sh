#!/bin/bash
set -e  # Fail on errors
set -x  # Verbosity all the way

## Setta variabili e percorsi
src=$PWD/"markdown"
origine=$PWD
temporanea=$PWD/"tmp"
dest=$PWD/"Chapters"

##prepara ambiente
mkdir -p ${src}
mkdir -p ${temporanea}
mkdir -p ${dest}

##aws cli
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

##configura aws

export AWS_ACCESS_KEY_ID=${id}
export AWS_SECRET_ACCESS_KEY=${key}
export AWS_DEFAULT_REGION=${region}


##scarica file sorgente
cd ${src}

aws s3 sync s3://tesi-src/markdown/ .

##concatena md

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

cd ${origine}

xelatex template_tesi.tex
biber template_tesi
xelatex template_tesi.tex

