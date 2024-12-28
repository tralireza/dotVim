#!/bin/bash

if [ "$DARKMODE" == "0" ]; then
  echo light > ~/.vim/system_colormode.txt
else
  echo dark > ~/.vim/system_colormode.txt
fi
