First we declare a variable 'team' which stores the team name whose scores we want to display. Then we start an infinite loop. In the loop everytime we do this:
download the rss feed from the site and store it in a file score.xml
the file contains score of all the live matches of all the teams
use grep command to look up score for the team we're looking for
replace the html character '&amp' by '&' using sed
remove by title tags by cutting using '>' and '<' as delimiters
same score will be written in two lines (because of the html sturctute of the rss feed) so just move forward with first line using "sort -u" command (makes lines unique, removes duplicates)
check if the current score string is same as the previous one (initially it will be empty); if not then send desktop notifications
make the current score string as previous one (stored as '$last') so that can be used in next iteration
sleep for 10 secs
goes into next iteration


first check if the output directories are already present if not then make the directories.
remove '/' from the end of directory names provided is present.
give all permissions to the files that we are going to transfer to other folders so that there is no issue with moving files to other folder.
store directories, filenames, persmissions in separate files and use awk in a loop to access elements of each file one by one.
find the extension of file
make appropriate folder then copy the file to the this folder
change the permission of the copied file as per the permissions.txt which contains the actual file permissions.
  
