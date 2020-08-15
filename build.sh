set +x

echo "I am running from dir: $PWD"
echo "I am runnign as user: $whoami"
echo 'hello world, Welcome to the workd of jenkins!!'

echo "print('running a python script')" > hello.py
python3 hello.py

echo "Program Run Status: $?"
echo "list of files present on this dir:"
ls -ltr

echo "End of the Program!"