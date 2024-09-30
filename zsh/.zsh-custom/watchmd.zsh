function watchmd() {
    inotifywait -m -e close_write --format '%w%f' . |
        while read file; do
            if [[ $file == *.md ]]; then
                echo -n "Building $(basename $file .md).pdf... "
                make $(basename $file .md).pdf > /dev/null            
                if [[ $? -eq 0 ]]; then
                    echo "OK"
                else
                    echo "KO"
                fi
            fi
        done
}
