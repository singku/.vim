path=`pwd`
while [  ! -f "$path/mtags" ] &&  [ $path != "/"  ]
do
	path=`dirname  $path`
done

if [  -f "$path/mtags" ] 
then
	echo $path
	cd $path
	./mtags
	cscope -bq 
fi
