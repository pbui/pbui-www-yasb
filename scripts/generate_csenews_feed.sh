#!/bin/sh

export PATH=/opt/anaconda-4.1.1/bin:$PATH

XML_PATH=/net/smb/pbui@fs.nd.edu/www/static/rss/csenews.xml

if (cd $(dirname $0) ; ./csenews.py) > ${XML_PATH}.tmp; then
    cp -f ${XML_PATH}.tmp ${XML_PATH}
    rm -f ${XML_PATH}.tmp
fi
