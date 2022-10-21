from subprocess import Popen, PIPE
process = Popen('sudo wsbrd -F examples/wsbrd.conf -u /dev/ttyACM0', shell=True, stdout=PIPE, bufsize = 50)
with process.stdout:
    for line in iter(process.stdout.readline, b''):
        handle(line)
returncode = process.wait()
