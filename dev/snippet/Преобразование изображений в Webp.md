---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-09-05
zero-link:
  - "[[../../meta/zero/00 Снипеты на bash|00 Снипеты на bash]]"
parents: 
linked: 
---
Следующий этап оптимизации изображений для сайта после [сжатия без потери качества](Сжатие%20изображений%20без%20потери%20качества.md) это преобразование всех изображений в формат WebP.

WebP - это формат сжатия изображений, разработанный компанией Google. Он использует современный алгоритм сжатия, который обеспечивает более эффективное сжатие, чем форматы JPEG и PNG, что может привести к быстрее загрузке веб-страниц и экономии интернет-трафика.

А вот и сам скрипт для преобразования в webp:

```shell
#!/bin/bash
file=webp.flag

if [ -f "$file" ]; then
  option="-newer $file"
fi

find ./struchkov.dev/www/images/ -type f -iregex '.*\.\(jpg\|jpeg\|png\)' $option -exec sh -c '
  webp_file="${1/\/images\//\/images\/webp\/}"
  webp_dir="$(dirname "$webp_file")"
  mkdir -p "$webp_dir"
  cwebp -mt -af -progress -m 6 -q 85 -pass 10 "$1" -o "${webp_file%.*}.webp"
' _ {} \;

touch "$file"
echo "$(date)" > "$file"
```

Также как и в первом скрипте, я использую файл-флаг, чтобы не преобразовывать файлы, которые уже преобразовывались.

Далее я беру папку `/struchkov.dev/www/images/`, в которой лежат исходные изображения и создаю новую папку `/struchkov.dev/www/images/webp`. Внутри папки `webp` структура папок и файлов такая же, как и в папке `images`. Только формат у файлов `.webp`.

За преобразование отвечает команда `cwebp`. Эта утилита сжимает изображения, но с потерями в качестве. Я подобрал оптимальные параметры сжатия, чтобы потеря качества была не заметна, но при этом изображения занимали меньше места.

```shell
cwebp -mt -af -progress -m 6 -q 85 -pass 10 "$1" -o "${webp_file%.*}.webp"
```

Подробнее об этих и других параметрах можно [почитать в документации](https://developers.google.com/speed/webp/docs/cwebp?hl=ru).
## Nginx
Теперь сделаем так, чтобы при запросе jpg/png изображения отдавался аналогичный webp файл. Для этого в конфигурацию nginx добавляем:

```nginx
location ~* ^(/blog/ru/content/images/)(.+)\.(png|jpe?g)$ {	
    expires max;
    alias /var/struchkov.dev/ghost/www/images;
    set $webp_image_subdir "/webp/";
    set $basename $2;
    try_files $webp_image_subdir$basename$webp_suffix $uri;
}
```

`try_files` сначала попытается достать webp изображение, если его нет, то возьмет основной изобращение.