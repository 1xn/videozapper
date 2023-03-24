#!/bin/bash
# MOVIE RANDOM ZAPPER Script v0.2
# (needs figlet + vlc to work!)

# Clear the screen
clear

# Loop indefinitely
while [ 1 = 1 ]
do
  # Specify the directory to use
  DIR="/home/dan/Desktop/videos/"

  # Set the Internal Field Separator to newline, so file names with spaces do not break the script
  IFS=$'\n'

  # Check if the specified directory exists
  if [[ -d "${DIR}" ]]; then
    # Run the 'find' command on the directory to find all movie files with supported extensions
    file_matrix=($(find "${DIR}" -type f -true -name "*.mpg" -o -name "*.avi" -o -name "*.mpeg" -o -name "*.mp4" -o -name "*.ogv"))

    # Get the number of movie files found
    num_files=${#file_matrix[*]}

    # Select a random movie file from the list
    MOVIE="${file_matrix[$((RANDOM%num_files))]}"
    
    # Clear the screen
    clear

    # Display a message using the 'figlet' command
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

    # Get the size of the selected movie file
    SIZE=$(stat --printf="%s" "$MOVIE")

    # Determine the maximum range of the random start position based on the size of the selected movie file
    if ((SIZE < 200000000)); then
      RANGOMAX=100
    else
      RANGOMAX=3600
    fi

    # Display the maximum range of the random start position
    echo "Max Range in Sec:" $RANGOMAX
    echo ""

    # Generate a random start position within the specified range
    POSITION=$((RANDOM % RANGOMAX + 3))

    # Play the selected movie file using VLC media player with the specified options
    cvlc --start-time=$POSITION --play-and-exit -q -f --no-video-title-show "$MOVIE"
  fi
done
