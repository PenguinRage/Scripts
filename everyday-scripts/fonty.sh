#!/bin/bash
function myfont() {
cd pwd
mv *.[ot]tf /usr/share/fonts/truetype
cd /usr/share/fonts/truetype
mkfontscale
mkfontdir
fc-cache
xset fp rehash
}
myfont
echo Your Font has been offically installed
