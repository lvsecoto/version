#!/bin/bash.exe
# get version
version=`git describe --abbrev=6`
version_full=`git describe --abbrev=6 --dirty`
version_simple=`git describe --abbrev=0`

# get element
tag=$version_simple
addition=`echo $version | sed -e "s/^\${tag}-\([0-9]\{1,\}\)-.*$/\1/g"`
id=`echo $version | sed -e "s/^\$tag-\$addition-\([0-9a-z]\{4,\}\)$/\1/g"`
dirty=`echo $version_full | sed -e "s/^\$tag\(-\$addition-\$id\)\{,1\}-\(dirty\)/\2/g"`

print_version()
{
	echo -e "\033[;33mversion\033[0m"
	echo "version: $version"
	echo "version_full: $version_full"
	echo "version_simple: $version_simple"
	echo "element: tag-addition-id-dirty"
	echo $tag
	echo $addition
	echo $id
	echo $dirty
}

generate_version_header()
{
	echo "${0%/*}/header.h.in"
	sed -e "s/<version>/$version/g" \
		-e "s/<version_full>/$version_full/g" \
		-e "s/<version_simple>/$version_simple/g" \
		-e "s/<tag>/$tag/g" \
		-e "s/<addition>/$addition/g" \
		-e "s/<ID>/$id/g" \
		-e "s/<dirty>/$dirty/g" \
		"${0%/*}/version.h.in"\
		> tmp;
	cat tmp > version.h
	rm tmp
}


while getopts "pc" arg
do
	case $arg in
		p)
			print_version
			;;
		c)
			generate_version_header
			;;
		?)
			echo "unknow argument"
			exit 1
			;;
	esac
done
