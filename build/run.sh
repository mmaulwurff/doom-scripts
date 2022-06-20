#!/bin/bash

# This script loads the current working directory as a GZDoom mod.

# The output is redirected to prevent character spam for some terminals.
gzdoom ./ "$@" > output 2>&1; cat output
