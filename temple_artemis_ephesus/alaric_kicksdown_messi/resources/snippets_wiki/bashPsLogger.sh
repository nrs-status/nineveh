# -- DESC: bash one liner that logs all processes every second

while true; do date +"%Y-%m-%d %H:%M:%S" >> pslog; ps -ef >> pslog; sleep 1; done
