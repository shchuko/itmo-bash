#!/bin/bash
# Printing pid of process was started last
psres=$(ps -A -o pid --sort=start_time); 
echo "$psres" | tail -n 1;

