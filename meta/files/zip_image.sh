#!/bin/bash
file=comp.flag

if [ -f "$file" ]; then
    option="-newer $file"
fi

find ./images/ -type f -not -path "./images/comp/*" ! -name "*-no-comp.*" $option -iname "*.png" -exec sh -c '
  png_file="./images/comp/${1#*/images/}"
  png_dir="$(dirname "$png_file")"
  mkdir -p "$png_dir"
  cp "$1" "$png_file"
  optipng -o7 "$png_file"
  advpng -z4 "$png_file"
  pngcrush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow "$png_file"
' _ {} \;

find ./images/ -type f -not -path "./images/comp/*" ! -name "*-no-comp.*" $option -iregex '.*\.\(jpg\|jpeg\)' -exec sh -c '
  jpg_file="./images/comp/${1#*/images/}"
  jpg_dir="$(dirname "$jpg_file")"
  mkdir -p "$jpg_dir"
  cp "$1" "$jpg_file"
  jpegoptim --all-progressive "$jpg_file"
' _ {} \;

find ./images/comp -type f -iregex '.*\.\(jpg\|jpeg\|png\)' -not -iregex '.*no-comp\.\(jpg\|jpeg\|png\)' $option -exec sh -c '
  webp_file="./images/webp/${1#*/images/comp/}"
  webp_dir="$(dirname "$webp_file")"
  mkdir -p "$webp_dir"
  cwebp -mt -af -progress -m 6 -q 75 -pass 10 "$1" -o "${webp_file%.*}.webp"
' _ {} \;

touch $file
echo "$(date)" > $file