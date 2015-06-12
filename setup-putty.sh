#! /bin/sh

#
# Configure PuTTY default settings
#

mkdir -p ~/.putty/sessions
echo "ScrollbackLines=20000
TermWidth=120
TermHeight=35
FontName=client:Monospace 12
Colour0=0,0,0
Colour1=85,85,85
Colour2=255,255,255
Colour3=187,187,187
Colour4=0,0,0
Colour5=0,0,0" > ~/.putty/sessions/Default%20Settings

