#!/usr/bin/expect
echo "############################################"
echo "#                                          #"
echo "#                                          #"
echo "#                                          #"
echo "#                                          #"
echo "#    git pull push auto script ver 1.0     #"
echo "#                                          #"
echo "#         written by sungminyou            #"
echo "#                                          #"
echo "#                                          #"
echo "#                                          #"
echo "############################################"
echo "\n"
echo "*** start pull ***"
echo "\n"
git pull
echo "\n"
echo -n "please enter a commit message >> "
read line
echo "\n"
expect << EOF
spawn sudo git add .
expect {
    -re {\[sudo\] password for sungminyou:} {send "Coder1771?!?moneY\r"}
}
expect eof
EOF
echo "\n"
expect << EOF
spawn sudo git commit -m "$line"
expect {
    -re {\[sudo\] password for sungminyou:} {send "Coder1771?!?moneY\r"}
}
expect eof
EOF
echo "\n"
git push
echo "\n"
echo "*** Pushing ended successfully ***"