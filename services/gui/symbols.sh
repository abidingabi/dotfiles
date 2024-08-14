#!/usr/bin/env sh

# the following elisp codes generates approximately symbols.txt.
# the real deal requires a tad bit of cleanup.
# i.e. removing carriage return, line feed, tab, null.
# (maphash
#  (lambda (key value)
#    (goto-char (point-max))
#    (insert (format "%s\t%s\n" (string value) key)))
#  (ucs-names))

WINDOW=$(xdotool getactivewindow)
SYMBOL=$(rofi -dmenu -i -input "/etc/nixos/services/gui/symbols.txt" | awk '{printf $1}')
# this is a hack; see https://github.com/jordansissel/xdotool/issues/150
xdotool key --clearmodifiers shift
xdotool windowfocus $WINDOW && xdotool type --window $WINDOW $SYMBOL
