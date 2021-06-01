#!/usr/bin/env bash

# Bash Script to convert mp4 to mp3
# By sandrioo
# email: sanjitvk8@gmail.com
# telegram: @sandrioo

# Requires
# ffmpeg installed
# lame installed

echo -ne """
1: Current directory
2: Provide directory
"""
echo ""
echo -n "Selection : "
read selection

case $selection in
    1)
	echo "Omk.."
	echo ""
	echo "Current dir is `pwd` "
	;;
    2)
    echo ""
    echo -n "Give diretory name: "
    read dir_name

# Check for validity
if [ -d $dir_name ]; then
    
    cd "${$dir_name}"
    echo "Current directory is `pwd` "
    echo 
else
    echo "Invalid directory, provide a valid directory, exitting."
    echo ""
    exit 10
fi

    echo
    ;;
    
   *)
       echo
       echo "Don't Create Your Own Choice Choose From The Given"
       exit 11
       ;;
esac

echo ""

# Create dir to store mp3 
# Get the current directory 

current_dir=`pwd`
base_name=` basename "$current_dir"`

if [[ ! -d "$base_name"-mp3 ]]; then
    
echo "$base_name" | xargs  -d "\n" -I {} mkdir {}-mp3
    echo ""
fi
echo ""


# start covertion of videos

find . -name "*.mp4" -o -name "*.mkv" -o -name "*.webm" | xargs  -d "\n"  -I {} ffmpeg -i {} -b:a 320K -vn "$base_name"-mp3/{}.mp3 

# remove video extensions

cd "${base_name}"-mp3

for file_name in *; do      
    mv "$file_name" "`echo $file_name | sed  "s/.mp4//g;s/.mkv//g;s/.webm//g"`";
done

# Move audio to ~/Music

if [[ ! -d ~/Music ]]; then
    mkdir ~/Music
fi
cd ..

mv  "$base_name"-mp3 ~/Music/

# Check conversion

echo ""

if [[ $? -eq "0" ]];then
    echo " All files are converted successfully, enjoy the music :p"
else
    echo "oops! something went wrong, retry again"
    exit 1
fi

