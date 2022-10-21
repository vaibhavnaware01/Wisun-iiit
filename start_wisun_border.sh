#!/bin/bash
# The MIT License (MIT)

# Copyright (c) 2015 Prashant Nandipati (prashantn@riseup.net)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
