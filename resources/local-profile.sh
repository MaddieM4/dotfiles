if [ -d "$HOME/.profile.d" ]; then
  for script in "$HOME"/.profile.d/*; do
    source $script
  done
fi
