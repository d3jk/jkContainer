# jkrun

## Purpose 
A rather clumsy container runtime written for fun in `bash`...just because...

## Disclaimer - This is a work-in-progress
Many limitations and bugs and probably many breaking changes will be introduced frequently. You've been warned!

## Compatibility
Very limited compatibility. 

Developed and tested for use with Ubuntu 20.04 host and Alpine rootfs tar file.

## Usage
### Run jkcontainer from tar file
`sudo jkrun -r path/to/image.tar`

Create a tar from an existing image
```
user@ubuntu:~$ podman export $(podman create alpine:3.5) -o alpine35.tar
```
```
user@ubuntu:~$ sudo jkrun -r alpine35.tar
|jkrun-> 7430
/ # hostname
jkrun
/ # ps
PID   USER     TIME   COMMAND
    1 root       0:00 /bin/sh
   42 root       0:00 ps
/ # exit
|jkrun-> Thanks, come again!
```
Run with very basic network setup

`sudo jkrun -nr path/to/image.tar`
```
user@ubuntu:~$ sudo jkrun -nr alpine35.tar
|jkrun-> 9276
|jkrun-> Host IP: 192.168.3.200
|jkrun-> Container IP: 192.168.3.100
/ # 
```
### Startup previously created jkcontainer
`sudo jkrun -s [container id]`
```
user@ubuntu:~$ sudo jkrun -s 9276
|jkrun-> starting container "9276"
|jkrun-> 9276
/ # 
```
Start previously created container with very basic network setup add `-n` flag
### List all created jkcontainers
`jkrun -l`
```
user@ubuntu:~$ jkrun -l
|jkrun-> Containers:
|jkrun->             1063
|jkrun->             1390
|jkrun->             1621
```
### Delete jkcontainer
`sudo jkrun -d [container id]`
```
user@ubuntu:~$ sudo jkrun -d 9120
|jkrun-> deleted container "9120"
```
