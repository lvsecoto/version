# version
version=`git describe`
version_full=`git describe --dirty`
version_simple=`git describe --abbrev=0`

echo "version:"
echo $version
echo $version_full
echo $version_simple

#element
tag=$version_simple
id=`echo $version | sed -e "s/^${tag}-\([0-9]+\)-.*"`
dirty=`echo $version_full | sed -e "s/.*\(dirty\)/\1/g"`

echo "element"
echo $tag
echo $id
echo $dirty

# commit=`echo 12 | sed -e "s/-[0-9]+-[0-9a-z]\{8}$//g"`
commit=`echo $version | sed -e "s/-[0-9]+/###/g"`
if [ `echo $temp_version | grep -e "-dirty$" -c` -ne 0 ]; then
	is_dirty=1
	echo "is dirty"
fi

