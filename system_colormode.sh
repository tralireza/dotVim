#!/bin/bash

if [ "$DARKMODE" == "0" ]; then
  echo light > ~/.vim/system_colormode.txt
  ln -sf ~/.config/alacritty/light.toml ~/.config/alacritty/theme.toml
else
  echo dark > ~/.vim/system_colormode.txt
  ln -sf ~/.config/alacritty/terminal_app.toml ~/.config/alacritty/theme.toml
fi
