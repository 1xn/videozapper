#!/bin/bash
# MOVIE RANDOM ZAPPER Script v0.2
# (needs figlet + vlc to work!)

clear
while [ 1 = 1 ]
do

# Specify here the directory to use
DIR="/home/dan/Desktop/videos/"
# Internal Field Separator set to newline, so file names with
#spaces do not break our script.
IFS='
'
if [[ -d "${DIR}" ]]
then

  # Runs find on the given dir, and dumps the output into a matrix,
  # it uses the new lines character as a field delimiter, as explained above.

  file_matrix=($( find "${DIR}" -type f -true -name "*.mpg" -o -name "*.avi" -o -name "*.mpeg" -o -name "*.mp4" -o -name "*.ogv" ))
  num_files=${#file_matrix[*]}

  # This is the command to run on a random file.

MOVIE="${file_matrix[$((RANDOM%num_files))]}"

# some nice output for the screen

clear
figlet "Zapper!"
echo ""
tput setaf 3
echo "The New Zapping Experience!"
echo ""
tput setaf 7
echo "Now Playing:"
echo ""
tput setaf 6
echo $MOVIE
echo ""
tput setaf 7

SIZE=`stat --printf="%s" $MOVIE`

echo "Size:" $SIZE
echo ""

RANGOMAX=3600
RANGOMIN=3

# Defines Random position between 1000 and 100 sec

if (("$SIZE" < "200000000")); then RANGOMAX=100;

else RANGOMAX=3600;

fi;

echo "Max Range in Sec:" $RANGOMAX ;

let POSITION=$RANDOM%$RANGOMAX+$RANGOMIN; echo $R;

cvlc --rc-show-pos --start-time=$POSITION --play-and-exit -q -f --no-video-title-show --global-key-quit="-" "$MOVIE"

fi

done
