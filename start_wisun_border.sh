#!/bin/bash
echo " --- Starting Wisun Border Router ---"
sudo pkill wsbrd
sudo wsbrd -F examples/wsbrd.conf | tee rssi_temp.txt &
sleep 2
sudo ip -6 address add fd12:3456::1/64 dev tun0 &
echo "[LOG] Waiting for border router to boot up"
sleep 10
echo "[LOG] Checking for Border Router IP"
COUNT=`ip address show tun0 | grep global | wc -l` #Check how many IPs are connected
if [[ "$COUNT" -eq 2 ]]; then
	echo "[LOG] Wisun Network online"
else
	echo "[LOG] Wisun Network not found! Exitting!"
fi
sleep 2
# Restart the existing services
echo "[LOG] Starting https.service systemd process"
sudo systemctl restart https.service && sudo systemctl status https.service
sleep 2
echo "[LOG] Starting recieve_test.service"
sudo systemctl restart receive_test.service && sudo systemctl status receive_test.service
echo "[LOG] Success"
