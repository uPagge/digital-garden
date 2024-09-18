#!/bin/bash

# Настройки
IMAGE_DIR="./images"
COMP_DIR="$IMAGE_DIR/comp"
WEBP_DIR="$IMAGE_DIR/webp"
THREADS=4  # Количество параллельных процессов

# Экспортируем необходимые переменные и функции для использования в subshell
export IMAGE_DIR COMP_DIR WEBP_DIR

# Функция для обработки PNG файлов
process_png() {
    local input_file="$1"
    local relative_path="${input_file#$IMAGE_DIR/}"
    local output_file="$COMP_DIR/$relative_path"
    local output_dir="$(dirname "$output_file")"

    mkdir -p "$output_dir"

    # Проверка хеша файла
    local hash_file="${output_file}.md5"
    local current_hash
    current_hash="$(md5sum "$input_file" | awk '{print $1}')"

    if [ -f "$hash_file" ]; then
        local previous_hash
        previous_hash="$(cat "$hash_file")"
        if [ "$current_hash" == "$previous_hash" ]; then
            echo "PNG файл не изменился: $input_file"
            return
        fi
    fi

    cp "$input_file" "$output_file"

    if ! optipng -o7 "$output_file"; then
        echo "Ошибка при сжатии $output_file с помощью optipng" >&2
        return 1
    fi

    if ! advpng -z4 "$output_file"; then
        echo "Ошибка при сжатии $output_file с помощью advpng" >&2
        return 1
    fi

    if ! pngcrush -rem gAMA -rem alla -rem cHRM -rem iCCP -rem sRGB -rem time -ow "$output_file"; then
        echo "Ошибка при сжатии $output_file с помощью pngcrush" >&2
        return 1
    fi

    echo "$current_hash" > "$hash_file"
}

# Функция для обработки JPEG файлов
process_jpeg() {
    local input_file="$1"
    local relative_path="${input_file#$IMAGE_DIR/}"
    local output_file="$COMP_DIR/$relative_path"
    local output_dir="$(dirname "$output_file")"

    mkdir -p "$output_dir"

    # Проверка хеша файла
    local hash_file="${output_file}.md5"
    local current_hash
    current_hash="$(md5sum "$input_file" | awk '{print $1}')"

    if [ -f "$hash_file" ]; then
        local previous_hash
        previous_hash="$(cat "$hash_file")"
        if [ "$current_hash" == "$previous_hash" ]; then
            echo "JPEG файл не изменился: $input_file"
            return
        fi
    fi

    cp "$input_file" "$output_file"

    if ! jpegoptim --all-progressive "$output_file"; then
        echo "Ошибка при сжатии $output_file с помощью jpegoptim" >&2
        return 1
    fi

    echo "$current_hash" > "$hash_file"
}

# Функция для конвертации в WebP
process_webp() {
    local input_file="$1"
    local relative_path="${input_file#$COMP_DIR/}"
    local output_file="$WEBP_DIR/$relative_path"
    output_file="${output_file%.*}.webp"
    local output_dir="$(dirname "$output_file")"

    mkdir -p "$output_dir"

    # Проверка хеша файла
    local hash_file="${output_file}.md5"
    local current_hash
    current_hash="$(md5sum "$input_file" | awk '{print $1}')"

    if [ -f "$hash_file" ]; then
        local previous_hash
        previous_hash="$(cat "$hash_file")"
        if [ "$current_hash" == "$previous_hash" ]; then
            echo "WebP файл не изменился: $input_file"
            return
        fi
    fi

    if ! cwebp -mt -af -progress -m 6 -q 75 -pass 10 "$input_file" -o "$output_file"; then
        echo "Ошибка при конвертации $input_file в WebP" >&2
        return 1
    fi

    echo "$current_hash" > "$hash_file"
}

# Экспорт функций для использования в subshell
export -f process_png
export -f process_jpeg
export -f process_webp

# Обработка PNG файлов
find "$IMAGE_DIR" -type f \
    -not -path "$COMP_DIR/*" \
    ! -name "*-no-comp.*" \
    -iname "*.png" -print0 | \
xargs -0 -P "$THREADS" -I {} bash -c 'process_png "$@"' _ {}

# Обработка JPEG файлов
find "$IMAGE_DIR" -type f \
    -not -path "$COMP_DIR/*" \
    ! -name "*-no-comp.*" \
    -iregex '.*\.\(jpg\|jpeg\)' -print0 | \
xargs -0 -P "$THREADS" -I {} bash -c 'process_jpeg "$@"' _ {}

# Конвертация в WebP
find "$COMP_DIR" -type f \
    -iregex '.*\.\(jpg\|jpeg\|png\)' \
    -not -iregex '.*no-comp\.\(jpg\|jpeg\|png\)' \
    -print0 | \
xargs -0 -P "$THREADS" -I {} bash -c 'process_webp "$@"' _ {}