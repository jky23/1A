1.
find -name "*.o" -type f

2.
find ./* -name "*.o" -type f -ls| wc -l

3.
find ./* -name core -!size0 -exec rm -f {}

8.
grep [chaine] fichier|tr ' ' '\n'|wc -l

10.
wc -L fichier
