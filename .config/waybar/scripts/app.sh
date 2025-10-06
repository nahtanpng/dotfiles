#!/usr/bin/env bash

app_class=$(hyprctl activewindow -j | jq -r '.class')

if [[ -z "$app_class" || "$app_class" == "null" ]]; then
  echo "no apps" 
else
  echo "$app_class"
fi