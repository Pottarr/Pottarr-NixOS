#!/bin/sh

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#006666cc'
TEXT='#aaaaaaff'
WRONG='#770000bb'
VERIFYING='#00aa99ff'

i3lock \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$VERIFYING     \
--bshl-color=$VERIFYING      \
\
--screen 1                   \
--blur 5                     \
--clock                      \
--indicator                  \
--time-str="%H:%M:%S"        \
--date-str="%d/%m/%Y"        \
--keylayout 1                \
