case $# in
0) ls;;
1) if [[$1 == '-d']]
      then find .-maxdepth 1 -type d
   else find $1 .-maxdepth 1
   fi;;
2) find $2 -maxdepth1 -type d;;
*) echo "Error
esac
       
