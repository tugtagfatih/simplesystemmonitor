
awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print "CPU Usage: " ($2+$4-u1) * 100 / (t-t1) "%"; }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)

total_mem=$(free -m |awk '/^Mem:/{print $2}')
available_mem=$(free -m | awk '/^Mem:/{print $7}')
percent_free=$(awk "BEGIN {printf \"%.2f\", ($available_mem/$total_mem)*100}")
echo "Total Memory: ${total_mem}MB      Free Memory: ${available_mem}MB             Free Memory: ${percent_free}%"

total_disk=$(df -m | grep '/dev/sdb' | awk '{print $2}')
available_disk=$(df -m | grep '/dev/sdb' | awk '{print $4}')
percent_available_disk=$(awk "BEGIN {printf \"%.2f\", ($available_disk/$total_disk)*100"})
echo "Total Disk: ${total_disk}MB      Available Disk: ${available_disk}MB        Free Disk: ${percent_available_disk}%"

echo -e "\nTop 5 processes by CPU usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo -e "\nTop 5 processes by memory usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6