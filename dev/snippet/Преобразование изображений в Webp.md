---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-05
zero-link:
  - "[[../../meta/zero/00 Снипеты на bash|00 Снипеты на bash]]"
parents: 
linked:
---
PNG и JPG являются хорошими форматами изображений, которые можно [сжать без потери качества](Сжатие%20изображений%20без%20потери%20качества.md). Однако, на сегодняшний день существует более современный формат WebP, который может показать еще более эффективные результаты при сжатии изображений, но с едва заметным ухудшением качества.

В [документации WebP](https://developers.google.com/speed/webp/docs/cwebp?hl=ru) перечислено множество параметров, которые повлияют на качество получаемого изображения. Вы можете провести экспериментальный подбор параметров онлайн на сайте [https://squoosh.app](https://squoosh.app/).

Я вы выбрал для себя следующий набор параметров:

```bash
cwebp -mt -af -progress -m 6 -q 80 -pass 10 input.jpg -o output.webp
```

Это команда преобразует JPG файл `input.jpg` в файл изображения WebP с именем `output.webp`. Команда включает несколько опций, которые управляют процессом кодирования:
- `-mt` включает многопоточность, что может улучшить производительность  на многоядерных процессорах.
- `-af` включает автоматическую фильтрацию, которая применяет алгоритм фильтрации для повышения эффективности сжатия.
- `-progress` выводит показывает процент обработки файла.
- `-m 6` устанавливает максимальное количество сегментов, используемых в процессе кодирования, равным 6, что может повысить эффективность сжатия за счет увеличения времени кодирования.
- `-q 80` устанавливает коэффициент качества на `80`, который контролирует степень сжатия и влияет на визуальное качество выходного изображения.
- `-pass 10` устанавливает число проходов кодирования равным 10, что может повысить эффективность сжатия за счет увеличения времени кодирования.


> [!WARNING] 
> `-lossless` позволяет использовать сжатие без потерь. Но тогда ваше новое изображение может оказаться существенно тяжелее исходного.

Улучшим [скрипт сжатия изображений](Сжатие%20изображений%20без%20потери%20качества.md) и добавим также преобразование в webp:

```bash title="zip_image.sh" {6, 15}
#!/bin/bash  
  
# Настройки  
IMAGE_DIR="./images"  
COMP_DIR="$IMAGE_DIR/comp"  
WEBP_DIR="$IMAGE_DIR/webp"  
# Автоматическое определение количества ядер процессора  
THREADS=$(getconf _NPROCESSORS_ONLN)  
echo "Используется $THREADS потоков для обработки."  
# Файлы логирования  
LOG_FILE="./zip_image_compression.log"  
ERROR_LOG_FILE="./zip_image_error.log"  
  
# Экспортируем необходимые переменные и функции для использования в subshell  
export IMAGE_DIR COMP_DIR WEBP_DIR LOG_FILE ERROR_LOG_FILE  
  
# Функция для определения размера файла  
get_file_size() {  
    local file="$1"  
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then  
        stat -c%s "$file"  
    elif [[ "$OSTYPE" == "darwin"* ]]; then  
        stat -f%z "$file"  
    else  
        # Попытка использовать GNU stat, если установлен  
        if command -v gstat &> /dev/null; then  
            gstat -c%s "$file"  
        else  
            # В качестве альтернативы используем wc -c  
            wc -c < "$file" | tr -d ' '  
        fi  
    fi}  
  
export -f get_file_size  
  
# Функция для логирования успеха  
log_success() {  
    local message="$1"  
    echo "$message"  
    echo "$(date '+%Y-%m-%d %H:%M:%S') $message" >> "$LOG_FILE"  
}  
  
# Функция для логирования ошибок  
log_error() {  
    local message="$1"  
    echo "$message" >&2  
    echo "$(date '+%Y-%m-%d %H:%M:%S') $message" >> "$ERROR_LOG_FILE"  
}  
  
# Экспортируем функции логирования  
export -f log_success  
export -f log_error  
  
# Функция для обработки PNG файлов  
process_png() {  
    local input_file="$1"  
    local relative_path="${input_file#$IMAGE_DIR/}"  
    local output_file="$COMP_DIR/$relative_path"  
    local output_dir  
    output_dir="$(dirname "$output_file")"  
  
    mkdir -p "$output_dir"  
  
    # Проверка файла ошибки  
    local error_file="${output_file}.error"  
    if [ -f "$error_file" ]; then  
        # Файл ошибки существует, пропускаем обработку  
        return  
    fi  
  
    # Проверка хеша файла  
    local hash_file="${output_file}.md5"  
    local current_hash  
    current_hash="$(md5sum "$input_file" | awk '{print $1}')"  
  
    if [ -f "$hash_file" ]; then  
        local previous_hash  
        previous_hash="$(cat "$hash_file")"  
        if [ "$current_hash" == "$previous_hash" ]; then  
            # Файл не изменился, ничего не делаем  
            return  
        fi  
    fi  
    # Используем временный файл для обработки  
    local temp_output_file="${output_file}.tmp"  
    cp "$input_file" "$temp_output_file"  
  
    # Размер до сжатия  
    local original_size  
    original_size=$(get_file_size "$input_file")  
  
    # Используем pngquant  
    if ! pngquant --quality=90-100 --speed 1 --output "$temp_output_file" --force "$input_file"; then  
        local error_msg="Ошибка при сжатии $input_file с помощью pngquant"        log_error "$error_msg"  
        echo "$error_msg" > "$error_file"  
        rm -f "$temp_output_file"  
        return 1  
    fi  
  
    # Дополнительная оптимизация с помощью zopflipng  
    if ! zopflipng -y "$temp_output_file" "$temp_output_file"; then  
        local error_msg="Ошибка при оптимизации $temp_output_file с помощью zopflipng"        log_error "$error_msg"  
        echo "$error_msg" > "$error_file"  
        rm -f "$temp_output_file"  
        return 1  
    fi  
  
    # Размер после сжатия  
    local new_size  
    new_size=$(get_file_size "$temp_output_file")  
  
    # Проверка, что original_size не равен нулю  
    if [ "$original_size" -eq 0 ]; then  
        local error_msg="Ошибка: размер оригинального файла равен 0 для $input_file"  
        log_error "$error_msg"  
        echo "$error_msg" > "$error_file"  
        rm -f "$temp_output_file"  
        return 1  
    fi  
  
    # Проверка, уменьшился ли размер файла  
    if [ "$new_size" -ge "$original_size" ]; then  
        log_success "Сжатие не уменьшило размер файла $input_file, пропускаем сохранение"  
        # Сохраняем хеш, чтобы не обрабатывать файл снова  
        echo "$current_hash" > "$hash_file"  
        rm -f "$temp_output_file"  
        return  
    fi  
  
    # Процент сжатия  
    local reduction  
    reduction=$(awk "BEGIN {printf \"%.2f\", (($original_size - $new_size) / $original_size) * 100}")  
  
    log_success "Сжат PNG файл: $input_file на $reduction% ($original_size байт -> $new_size байт)"  
    # Перемещаем временный файл на место выходного  
    mv "$temp_output_file" "$output_file"  
  
    # Сохраняем хеш  
    echo "$current_hash" > "$hash_file"  
}  
export -f process_png  
  
# Функция для обработки JPEG файлов  
process_jpeg() {  
    local input_file="$1"  
    local relative_path="${input_file#$IMAGE_DIR/}"  
    local output_file="$COMP_DIR/$relative_path"  
    local output_dir  
    output_dir="$(dirname "$output_file")"  
  
    mkdir -p "$output_dir"  
  
    # Проверка файла ошибки  
    local error_file="${output_file}.error"  
    if [ -f "$error_file" ]; then  
        # Файл ошибки существует, пропускаем обработку  
        return  
    fi  
  
    # Проверка хеша файла  
    local hash_file="${output_file}.md5"  
    local current_hash  
    current_hash="$(md5sum "$input_file" | awk '{print $1}')"  
  
    if [ -f "$hash_file" ]; then  
        local previous_hash  
        previous_hash="$(cat "$hash_file")"  
        if [ "$current_hash" == "$previous_hash" ]; then  
            # Файл не изменился, ничего не делаем  
            return  
        fi  
    fi  
    # Используем временный файл для обработки  
    local temp_output_file="${output_file}.tmp"  
    cp "$input_file" "$temp_output_file"  
  
    # Размер до сжатия  
    local original_size  
    original_size=$(get_file_size "$input_file")  
  
    # Используем mozjpeg  
    if ! cjpeg -quality 95 -progressive -optimize -outfile "$temp_output_file" "$input_file"; then  
        local error_msg="Ошибка при сжатии $input_file с помощью mozjpeg"        log_error "$error_msg"  
        echo "$error_msg" > "$error_file"  
        rm -f "$temp_output_file"  
        return 1  
    fi  
  
    # Размер после сжатия  
    local new_size  
    new_size=$(get_file_size "$temp_output_file")  
  
    # Проверка, что original_size не равен нулю  
    if [ "$original_size" -eq 0 ]; then  
        local error_msg="Ошибка: размер оригинального файла равен 0 для $input_file"  
        log_error "$error_msg"  
        echo "$error_msg" > "$error_file"  
        rm -f "$temp_output_file"  
        return 1  
    fi  
  
    # Проверка, уменьшился ли размер файла  
    if [ "$new_size" -ge "$original_size" ]; then  
        log_success "Сжатие не уменьшило размер файла $input_file, пропускаем сохранение"  
        # Сохраняем хеш, чтобы не обрабатывать файл снова  
        echo "$current_hash" > "$hash_file"  
        rm -f "$temp_output_file"  
        return  
    fi  
  
    # Процент сжатия  
    local reduction  
    reduction=$(awk "BEGIN {printf \"%.2f\", (($original_size - $new_size) / $original_size) * 100}")  
  
    log_success "Сжат JPEG файл: $input_file на $reduction% ($original_size байт -> $new_size байт)"  
    # Перемещаем временный файл на место выходного  
    mv "$temp_output_file" "$output_file"  
  
    # Сохраняем хеш  
    echo "$current_hash" > "$hash_file"  
}  
export -f process_jpeg  
  
# Функция для конвертации в WebP  
process_webp() {  
    local input_file="$1"  
    local relative_path="${input_file#$IMAGE_DIR/}"  
    local output_file="$WEBP_DIR/$relative_path"  
    output_file="${output_file%.*}.webp"  
    local output_dir  
    output_dir="$(dirname "$output_file")"  
  
    mkdir -p "$output_dir"  
  
    # Проверка файла ошибки  
    local error_file="${output_file}.error"  
    if [ -f "$error_file" ]; then  
        # Файл ошибки существует, пропускаем обработку  
        return  
    fi  
  
    # Проверка хеша файла  
    local hash_file="${output_file}.md5"  
    local current_hash  
    current_hash="$(md5sum "$input_file" | awk '{print $1}')"  
  
    if [ -f "$hash_file" ]; then  
        local previous_hash  
        previous_hash="$(cat "$hash_file")"  
        if [ "$current_hash" == "$previous_hash" ]; then  
            # Файл не изменился, ничего не делаем  
            return  
        fi  
    fi  
    # Размер до конвертации  
    local original_size  
    original_size=$(get_file_size "$input_file")  
  
    # Создаем временный файл для вывода  
    local temp_output_file="${output_file}.tmp"  
  
    if ! cwebp -mt -af -quiet -m 6 -q 95 -pass 10 "$input_file" -o "$temp_output_file"; then  
        local error_msg="Ошибка при конвертации $input_file в WebP"        log_error "$error_msg"  
        echo "$error_msg" > "$error_file"  
        rm -f "$temp_output_file"  
        return 1  
    fi  
  
    # Размер после конвертации  
    local new_size  
    new_size=$(get_file_size "$temp_output_file")  
  
    # Проверка, что original_size не равен нулю  
    if [ "$original_size" -eq 0 ]; then  
        local error_msg="Ошибка: размер оригинального файла равен 0 для $input_file"  
        log_error "$error_msg"  
        echo "$error_msg" > "$error_file"  
        rm -f "$temp_output_file"  
        return 1  
    fi  
  
    # Проверка, уменьшился ли размер файла  
    if [ "$new_size" -ge "$original_size" ]; then  
        log_success "Конвертация в WebP не уменьшила размер файла $input_file, пропускаем сохранение"  
        # Сохраняем хеш, чтобы не обрабатывать файл снова  
        echo "$current_hash" > "$hash_file"  
        rm -f "$temp_output_file"  
        return  
    fi  
  
    # Процент сжатия  
    local reduction  
    reduction=$(awk "BEGIN {printf \"%.2f\", (($original_size - $new_size) / $original_size) * 100}")  
  
    log_success "Конвертирован в WebP: $input_file на $reduction% ($original_size байт -> $new_size байт)"  
    # Перемещаем временный файл на место выходного  
    mv "$temp_output_file" "$output_file"  
  
    # Сохраняем хеш  
    echo "$current_hash" > "$hash_file"  
}  
export -f process_webp  
  
# Обработка PNG файлов  
find "$IMAGE_DIR" -type f \  
    -not -path "$COMP_DIR/*" \  
    -not -path "$WEBP_DIR/*" \  
    ! -name "*-no-comp.*" \  
    -iname "*.png" -print0 | \  
xargs -0 -P "$THREADS" -I {} bash -c 'process_png "$@"' _ {}  
  
# Обработка JPEG файлов  
find "$IMAGE_DIR" -type f \  
    -not -path "$COMP_DIR/*" \  
    -not -path "$WEBP_DIR/*" \  
    ! -name "*-no-comp.*" \  
    -iregex '.*\.\(jpg\|jpeg\)' -print0 | \  
xargs -0 -P "$THREADS" -I {} bash -c 'process_jpeg "$@"' _ {}  
  
# Конвертация в WebP из исходных файлов  
find "$IMAGE_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) \  
    -not -path "$COMP_DIR/*" \  
    -not -path "$WEBP_DIR/*" \  
    ! -name "*-no-comp.*" \  
    -print0 | \  
xargs -0 -P "$THREADS" -I {} bash -c 'process_webp "$@"' _ {}
```

Мы берем сжатые изображения из папки `comp` и преобразуем их в WebP, складывая в отдельную папку `webp`. Если вы захотите использовать другие параметры сжатия, вы всегда сможете пересоздать изображения с новыми параметрами.
## Тесты преобразования
Сожмем наши файл размером в 2,7 мб и 2.2 в формат WebP с разными параметрами качества:
- -q 90: Размер 325 кб.
- -q 85: Размер 267 кб.
- -q 80: Размер 229 кб.
- -q 75: Размер 200 кб.
- -q 70: Размер 191 кб.
- -q 60: Размер 176 кб.
- -q 50: Размер 163 кб.
- -q 40: Размер 147 кб.
- -q 30: Размер 129 кб.
- -q 20: Размер 115 кб.
- -q 10: Размер 90 кб.
- -q 1: Размер 70 кб. Для экстренных случаев. Например, вы заблудились в лесу и надо отправить фото по спутниковой сети 😅

Пример использования на реальных изображениях моего блога
![[../../meta/files/images/Pasted image 20240925144640.png]]
## Nginx
Теперь мы научим nginx при запросе изображений сначала пытаться найти WebP файл, и только потом отдавать сжатый PNG/JPG, а если и сжатого нет, то отдавать обычный файл.

Для этого напишем следующий `location`:

```nginx
location ~* ^(/blog/ru/content/images/)(.+)\.(png|jpe?g)$ { 
	expires 1d;
	add_header Cache-Control "public, must-revalidate, proxy-revalidate";
	root /var/site/images;
	try_files /webp/$2.webp /comp/$2.$3 $uri =404;
}
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты на bash|00 Снипеты на bash]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-09-05]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
