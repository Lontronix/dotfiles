#! /bin/bash

IMAGE_PATH="/tmp/lock.png"
maim IMAGE_PATH
mogrify -resize 5% IMAGE_PATH
mogrify -resize 2000% IMAGE_PATH
i3lock -i IMAGE_PATH
rm IMAGE_PATH
