#!/usr/bin/env bash

polybar-msg cmd quit

polybar dock 2>&1 & disown
