#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
export DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

aria2c \
--daemon=true \
--continue=true \
--min-split-size=1M \
--max-connection-per-server=4 \
--split=4 \
--enable-rpc \
--rpc-secret=aria2rpc-firefox \
--rpc-listen-all=true \
--rpc-allow-origin-all=true \
--check-certificate=false \
--dir="$HOME/Downloads" \
--on-download-start="$DIR/on-download-start.sh" \
--on-download-complete="$DIR/on-download-complete.sh" \
--referer='*' \
--load-cookies="$HOME/.mozilla/firefox/s2f9j04y.default/cookies.sqlite" \