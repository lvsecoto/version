version_full=`git describe --dirty`
version=`git describe`
version_simple=`git describe --abbrev=0`
dirty=`echo $version_full | sed -e "s/.*\(dirty\)/\1/g"`

# commit=`echo 12 | sed -e "s/-[0-9]+-[0-9a-z]\{8}$//g"`
commit=`echo $version | sed -e "s/-[0-9]+/###/g"`


echo "full version is $version_full"
echo "version is $version"
echo "simple version is $version_simple"
echo "version is $dirty"
echo "commit id is $commit"

if [ `echo $temp_version | grep -e "-dirty$" -c` -ne 0 ]; then
	is_dirty=1
	echo "is dirty"
fi

