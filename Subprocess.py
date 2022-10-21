from subprocess import Popen, PIPE
import re
process= Popen("sudo wsbrd -F examples/wsbrd.conf -u /dev/ttyACM0", shell='true',stdout=PIPE, bufsize = 10)
with process.stdout:
    for line in iter(process.stdout.readline, b''):
        print(line)
returncode = process.wait()