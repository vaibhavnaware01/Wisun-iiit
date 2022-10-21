import subprocess
import sys
import os


proc = subprocess.Popen(f"sudo wsbrd -F {os.getcwd()}/examples/wsbrd.conf -u /dev/ttyACM0",stdout=subprocess.PIPE)
str_ = ""
for c in iter(lambda:proc.stdout.read(1),b""):
	#sys.stdout.buffer.write(c)
	#f.buffer.write(c)
	str_ += chr(c)
	print(str_[str_.find("rssi"):])
