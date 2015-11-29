#!/bin/bash

cd /home/mrizzoli/.conky

for file in conky*
do
    conky -c ${file}
done
