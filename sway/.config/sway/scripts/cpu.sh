# must print:
#   x.x% user, x.x% sys, x.x% idle
# grep 'cpu ' /proc/stat
#      user    nice system idle     iowait irq softirq steal guest guest_nice
# cpu  1300913 1288 454044 25220171 91048  0   28943   0     0     0
grep 'cpu ' /proc/stat | \
awk '{
    user=$2+$3
    sys=$4
    idle=$5
    total=user+sys+idle
    printf "%.1f%% user, %.1f%% sys, %.1f%% idle\n", user/total*100, sys/total*100, idle/total*100
}'
