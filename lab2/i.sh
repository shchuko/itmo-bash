#!/bin/bash

grep -Erhs "^ACPI.*" /var/log > errors.log;
grep -E "(^|[^A-Za-z0-9])/([a-zA-Z0-9]+/?)+" errors.log;

