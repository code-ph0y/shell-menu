#!/bin/bash

echo "Current memory:";
echo;
free -h 2>/dev/null || vm_stat
