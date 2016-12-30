#!/bin/bash.exe
prefix="-"

test_git()
{
	# test tag. Need at least one tag.
	git describe  2>/dev/null >/dev/null
	if [ $? -ne 0 ];then
		echo Get version faild!
		echo Make sure you project has one tag at least.
		return 1
	else
		return 0
	fi
}

get_version()
{
	# get version
	version=`git describe --abbrev=5`
	version_full=`git describe --abbrev=5 --dirty`
	version_simple=`git describe --abbrev=0`

	# get element
	tag=$version_simple
	addition=`echo $version | sed -e "s/^\${tag}-\([0-9]\{1,\}\)-.*$/\1/g"`
	id=`echo $version | sed -e "s/^\$tag-\$addition-\([0-9a-z]\{4,\}\)$/\1/g"`
	dirty=`echo $version_full | sed -e "s/^\$tag\(-\$addition-\$id\)\{,1\}-\(dirty\)$/\2/g"`

	tag_prefix=$prefix$tag

	if [ $addition = $version ];then
		# no addition detect
		addition=""
		addition_prefix=""
	else
		addition_prefix=$prefix$addition
	fi

	if [ $id = $version ];then
		# no id detect
		id=""
		id_prefix=""
	else
		id_prefix=$prefix$id
	fi

	if [ $dirty = $version_full ];then
		# no dirty detect
		dirty=""
	else
		dirty_prefix=$prefix$dirty
	fi
}
print_version()
{
	echo -e "\033[;33mversion\033[0m"
	echo "version: $version"
	echo "version_full: $version_full"
	echo "version_simple: $version_simple"
	echo -e "\033[;33melement: tag-addition-id-dirty\033[0m"
	echo $tag
	echo $addition
	echo $id
	echo $dirty
	echo $tag_prefix
	echo $addition_prefix
	echo $id_prefix
	echo $dirty_prefix
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
		-e "s/<tag_prefix>/$tag_prefix/g" \
		-e "s/<addition_prefix>/$addition_prefix/g"\
		-e "s/<ID_prefix>/$id_prefix/g"\
		-e "s/<dirty_prefix>/$dirty_prefix/g"\
		"version.h.in"\
		> tmp;
	cat tmp > version.h
	rm tmp
}


test_git
if [ $? -eq 0 ]; then
	get_version
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
fi
