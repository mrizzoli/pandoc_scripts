#!/bin/bash
 
#wskey=$(<oclc-wskey.txt)
#query=$1
 
#wget "http://www.worldcat.org/webservices/catalog/search/opensearch?q="${query}"&wskey=ots1dudySQxh5DqsrsL9oc7DLbuZbGaXh5VdMlMXMWbtRPCIXJLhvNPqGrUkN90mMyCZhlXVZ7QrEm8e" -O $2

wget "http://www.worldcat.org/webservices/catalog/content/citations/660034495?&cformat=apa&wskey=ots1dudySQxh5DqsrsL9oc7DLbuZbGaXh5VdMlMXMWbtRPCIXJLhvNPqGrUkN90mMyCZhlXVZ7QrEm8e" -O $1