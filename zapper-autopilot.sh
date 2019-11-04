#!/bin/bash

clear

# MOVIE RANDOM ZAPPER Script by Daniel F. Wehleit 2010
# www.1xN.org // dan@1xN.org

while [ 1 = 1 ]
	
do

# The directory to scan
DIR="/media/THE ONE/VIDEO/English/Movies/"

# Internal Field Separator set to newline, so file names with
# spaces do not break our script.
IFS='
'
 
if [[ -d "${DIR}" ]]
then

  # Runs ls on the given dir, and dumps the output into a matrix,
  # it uses the new lines character as a field delimiter, as explained above.

  file_matrix=($(ls -R "${DIR}"))
  num_files=${#file_matrix[*]}

  # Defines Random position between 1000 and 100 sec

let POSITION=$RANDOM%3000+100; echo $R

  # This is the command to run on a random file.

cvlc -I rc --start-time=$POSITION --run-time=30 --play-and-exit -f -q --no-video-title-show "${DIR}/${file_matrix[$((RANDOM%num_files))]}"

fi

done

