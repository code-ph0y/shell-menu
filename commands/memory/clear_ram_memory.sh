#!/bin/bash

echo 'Before:';
echo;
# Show Memory
free -m;
# Clear the Random Access Memory
echo;
sudo sh -c "sync; echo '3' > /proc/sys/vm/drop_caches";
echo;
echo 'After:';
echo;
# Show Memory
free -m;
