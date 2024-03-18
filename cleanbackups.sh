#!/bin/bash

# Copyleft (C) 2024 github.com/Aterocana
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.

cd backups && ls | grep -v .gitkeep | xargs rm -rf &> /dev/null && cd .. || exit 0
