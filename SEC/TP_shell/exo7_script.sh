if [[ ! -z "$1" ]]
then
     echo $1 | rev
else
     echo "Error"
     echo "Syntaxe : inv <chaine non vide> "
fi
