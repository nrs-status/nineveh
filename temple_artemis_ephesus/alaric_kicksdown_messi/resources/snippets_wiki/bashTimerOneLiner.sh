# -- DESC: bash timer that increases by one every second; single line command

while true; do echo $((COUNT++)); sleep 1; done
