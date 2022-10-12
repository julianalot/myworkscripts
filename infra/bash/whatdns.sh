#!/bin/bash
nmcli dev show | grep DNS | sed 's/\s\s*/\t/g' | cut -f 2
