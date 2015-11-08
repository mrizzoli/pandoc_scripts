#!/bin/bash

geeknote find --tags todo | grep -o '@.*' | sort
