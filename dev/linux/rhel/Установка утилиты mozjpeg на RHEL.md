---
aliases: 
tags:
  - maturity/🌱
  - "#content/problem"
date: 2024-09-25
zero-link:
  - "[[00 Разработка]]"
parents: 
linked:
---
mozjpeg не устанавливается из обычных пакетных менеджеров для RHEL, его необходимо собирать вручную.

**Mozjpeg** использует **CMake** для сборки. Установим необходимые утилиты
```shell
sudo yum install cmake nasm make gcc git
```

Склонируем репозиторий:
```shell
git clone https://github.com/mozilla/mozjpeg.git
```

Соберем и установим **mozjpeg**
```shell
cd mozjpeg
mkdir build && cd build
cmake -G"Unix Makefiles" ..
make
sudo make install
```


> [!INFO] Путь установки
> По умолчанию **mozjpeg** устанавливается в каталог /opt/mozjpeg.

Добавим mozjpeg в PATH
```shell
export PATH=/opt/mozjpeg/bin:$PATH
```

Проверим, что все установилось успешно
```shell
cjpeg -version
```
## Проблема при установке
Во время запуска cmake я получил следующую проблему.

```shell
$ cmake -G"Unix Makefiles" ..

....

-- Found ZLIB: /usr/lib64/libz.so (found version "1.2.11")  
-- Found PNG: /usr/lib64/libpng.so (found suitable version "1.6.37", minimum required is "1.6") 
-- PNG reading support enabled (PNG_SUPPORTED = 1)
-- Could NOT find ZLIB (missing: ZLIB_LIBRARY) (found version "1.2.11")
CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:230 (message):
  Could NOT find PNG (missing: PNG_LIBRARY) (Required is at least version
  "1.6")
Call Stack (most recent call first):
  /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:600 (_FPHSA_FAILURE_MESSAGE)
  /usr/share/cmake/Modules/FindPNG.cmake:159 (find_package_handle_standard_args)
  CMakeLists.txt:778 (find_package)


-- Configuring incomplete, errors occurred!
```

Проблема связана с отсутствием необходимых библиотек разработки для **zlib** и **libpng**. Хотя из вывода **CMake** видно, что сначала он находит библиотеки **ZLIB** и **PNG**:

```shell
-- Found ZLIB: /usr/lib64/libz.so (found version "1.2.11")  
-- Found PNG: /usr/lib64/libpng.so (found suitable version "1.6.37", minimum required is "1.6") 
```

Я попытался установить нужные пакеты, но они уже были установлены.
```shell
sudo yum install zlib-devel libpng-devel
```

Я проверил наличие библиотек и заголовочных файлов. Они также были на месте.
```shell
ls /usr/lib64/libz.*
ls /usr/lib64/libpng.*
ls /usr/include/zlib.h
ls /usr/include/png.h
```

Я попробовал установить **pkg-config**, который помогает **CMake** находить пути к библиотекам и заголовочным файлам. И проверил, что **pkg-config** возвращает пути к библиотекам.

```shell
sudo yum install pkgconfig
pkg-config --libs zlib
pkg-config --libs libpng
```

Я пытался использовать cmake3 указывая пути до библиотек
```shell
cmake3 -G"Unix Makefiles" \
  -DZLIB_LIBRARIES=/usr/lib64/libz.so \
  -DZLIB_INCLUDE_DIR=/usr/include \
  -DPNG_LIBRARY=/usr/lib64/libpng.so \
  -DPNG_PNG_INCLUDE_DIR=/usr/include \
  ..
```

В итоге я решил просто отключить поддержку PNG для mozjpeg, раз с ней возникают проблемы, так как я планирую использовать mozjpeg только для сжатия jpeg файлов.

```shell
cmake -G"Unix Makefiles" -DPNG_SUPPORTED=OFF ..
```

И это в итоге помогло.
***
## Мета информация
**Область**:: [[../../../meta/zero/00 Разработка|00 Разработка]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-09-25]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
