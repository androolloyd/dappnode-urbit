#!/nix/store/6h0xx5d8wwl8zf7g4x2sjl0q4hr3nnb4-bash-interactive-4.4-p23/bin/bash

set -eu

# If the container is not started with the `-i` flag
# then STDIN will be closed and we need to start
# Urbit/vere with the `-t` flag.
ttyflag=""
if [ ! -t 0 ]; then
  echo "Running with no STDIN"
  ttyflag="-t"
fi

# Check if there is a keyfile, if so boot a ship with its name, and then remove the key
if [ -e boot.key ] && [ -n "$PLANET_NAME" ]; then
  # Get the name of the key
  # hack for dappnode
  mv boot.key "$PLANET_NAME.key"
  keynames="*.key"
  keys=( $keynames )
  keyname=${keys[0]}
  mv $keyname /tmp

  # Boot urbit with the key, exit when done booting
  urbit $ttyflag -w $(basename $keyname .key) -k /tmp/$keyname -c $(basename $keyname .key) -p 34343 -x

  # Remove the keyfile for security
  rm /tmp/$keyname
  rm *.key || true
elif [ -e *.comet ]; then
  cometnames="*.comet"
  comets=( $cometnames )
  cometname=${comets[0]}
  rm *.comet

  urbit $ttyflag -c $(basename $cometname .comet) -p 34343 -x
fi

# Find the first directory and start urbit with the ship therein
dirnames="*/"
dirs=( $dirnames )
dirname=${dirnames[0]}

urbit $ttyflag -p 34343 $dirname
