echo "Removing 'work' and 'out' directory if they exist..."
sudo rm -rf work out
echo "Now making ISO, eyes up people..."
sudo ./make-iso -v "."
