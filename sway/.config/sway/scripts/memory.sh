# print memory usage in percentage
grep -E '^Mem' /proc/meminfo | awk '{
    if ($1 ~ /MemTotal:/) { total = $2; }
    if ($1 ~ /MemAvailable:/) { available = $2; }
} END {
    printf "Mem %.0f%%", (total - available) / total * 100;
}'
