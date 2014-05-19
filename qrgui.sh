#!/bin/bash
#
# Copyright (C) 2014 ssdclickofdeath
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

TMP=/tmp/stdout
ICON=qricon.png

#Makes text box for QR code text, and saves it to the QRSTRING variable.
QRSTRING=$(zenity --entry \
                  --title="QR Encoder" \
                  --window-icon=$ICON \
                  --text="Enter text to encode into a QR code." \
                  --width=300) #; echo $? > $TMP)

#Checks if window was closed by looking for exit code 1, if so, the program is closed
#[ `cat $TMP` = 1 ] && echo "Exiting qrgui..."; rm $TMP; exit 0;

# Makes an empty variable to compare to QRSTRING to check for empty text entry.
BLANK=""

#Compares QRSTRING to BLANK to see if text entry field is blank.
#If the field is blank, make a dialog box showing the error.
if [ $QRSTRING = $BLANK ]; then
       zenity --error \
              --width=270 \
              --title="QR Encoder" \
              --window-icon=$ICON \
     --text="The text entry field cannot be blank. QR Encoder will now close." \
              --timeout=4
              exit 1;
fi

# Please enter some text inside the field. This program will now close.

#Sets the variable FILENAME to the name and path to save the QR code.
FILENAME=$(zenity --file-selection \
              --window-icon=$ICON \
              --title="Save QR Code - QR Encoder" \
              --save \
              --confirm-overwrite) #; echo $? > $TMP)

#Checks if window was closed by looking for exit code 1, if so, the program is closed
#[ `cat $TMP` = 1 ] && echo "Exiting qrgui..."; rm $TMP; exit 0;

#Generates the QR code.
qrencode -o "$FILENAME" "$QRSTRING"

#Exits the shell script.
#rm $TMP
exit 0;
