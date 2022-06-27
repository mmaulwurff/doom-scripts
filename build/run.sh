#!/bin/bash

# SPDX-FileCopyrightText: 2022 Alexander Kromm <mmaulwurff@gmail.com>
#
# SPDX-License-Identifier: MIT

# This script loads the current working directory as a GZDoom mod.

# The output is redirected to prevent character spam for some terminals.
gzdoom ./ "$@" > output 2>&1; cat output
