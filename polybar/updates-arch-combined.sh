#!/bin/sh

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if updates_aur=$(yay -Qum) && [ -n "$updates_aur" ]; then
    updates_aur=$(echo "$updates_aur" | wc -l)
else
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo "# $updates updates"
else
    echo ""
fi
