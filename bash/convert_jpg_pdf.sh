#http://www.imagemagick.org/script/command-line-processing.php
FILES=*.jpeg
for f in $FILES
do
	#remove the .jpeg
	new=${f//.jpeg/.pdf}
	echo "Converting filename - $f to $new"
	magick "$f" "$new"
done
