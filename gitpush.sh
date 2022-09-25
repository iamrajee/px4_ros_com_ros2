pwd > /home/rajendra/helloWorld/pwd.txt
cd ~/px4_ros_com_ros2
/usr/bin/expect -c 'spawn git add .; interact'
/usr/bin/expect -c 'spawn git commit -m "updated"; interact'
#/usr/bin/expect -c 'spawn git pull origin main; expect "Username:"; send "iamrajee\n"; expect "password:"; send "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\n"; interact'
/usr/bin/expect -c 'spawn git push origin main; expect "Username:"; send "iamrajee\n"; expect "password:"; send "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\n"; interact'
cd `cat pwd.txt`
#cd `pwd`
#clear

