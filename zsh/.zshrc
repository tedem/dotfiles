# Clean ZIP Files by removing __MACOSX folders and .DS_Store files
clean_zip() {
    if [ -z "$1" ]; then
        echo -e "\033[31mLütfen bir zip dosyası belirtin.\033[0m"
        return 1
    fi

    local zipfile="$1"

    if [ ! -f "$zipfile" ]; then
        echo -e "\033[31mDosya bulunamadı: $zipfile\033[0m"
        return 1
    fi

    echo -e "\033[34mTemizleniyor: $zipfile\033[0m"

    macosx_exists=$(unzip -l "$zipfile" | grep -c "__MACOSX")
    dsstore_exists=$(unzip -l "$zipfile" | grep -c ".DS_Store")

    if [ "$macosx_exists" -gt 0 ]; then
        zip -d "$zipfile" "__MACOSX/*"
        echo -e "\033[32m__MACOSX klasörleri silindi.\033[0m"
    fi

    if [ "$dsstore_exists" -gt 0 ]; then
        zip -d "$zipfile" "*/.DS_Store"
        echo -e "\033[32m.DS_Store dosyaları silindi.\033[0m"
    fi

    if [ "$macosx_exists" -eq 0 ] && [ "$dsstore_exists" -eq 0 ]; then
        echo -e "\033[33mSilinecek hiçbir dosya bulunamadı.\033[0m"
    fi
}

# Herd CLI Tool
export PATH="/Users/tedem/Library/Application Support/Herd/bin/":$PATH

# Herd PHP INI Scan Directories
export HERD_PHP_74_INI_SCAN_DIR="/Users/tedem/Library/Application Support/Herd/config/php/74/"
export HERD_PHP_80_INI_SCAN_DIR="/Users/tedem/Library/Application Support/Herd/config/php/80/"
export HERD_PHP_81_INI_SCAN_DIR="/Users/tedem/Library/Application Support/Herd/config/php/81/"
export HERD_PHP_82_INI_SCAN_DIR="/Users/tedem/Library/Application Support/Herd/config/php/82/"
export HERD_PHP_83_INI_SCAN_DIR="/Users/tedem/Library/Application Support/Herd/config/php/83/"
export HERD_PHP_84_INI_SCAN_DIR="/Users/tedem/Library/Application Support/Herd/config/php/84/"
export HERD_PHP_85_INI_SCAN_DIR="/Users/tedem/Library/Application Support/Herd/config/php/85/"
