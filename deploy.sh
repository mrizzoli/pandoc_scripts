#!/bin/bash
#variables:
repo="https://github.com/mrizzoli/mrizzoli.github.io.git"
dest="/home/marco/mrizzoli.github.io/deploy"
src="/home/marco/mrizzoli.github.io/src/_site"

if [ ! -d "$dest" ]; then
   echo "cloning "$repo" into "$dir" " && git clone $repo $dest

else
    echo "mi metto in pari con upstream" && cd $dest && git pull origin master
fi

echo "syncing "$src" with "$dest" "

rsync -av $src/ $dest

cd $dest && git add . && git commit -m "update" && git push origin master 
