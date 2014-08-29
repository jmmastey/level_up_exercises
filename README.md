# Level Up Exercises

These are the combined exercises used at http://leveluprails.herokuapp.com. You can do them out of sequence, but you'll probably be missing the point. Do the right thing, visit the site.

## How to Do These Exercises

1. Fork this repo into your own space
2. Wait until you're asked to do one of the exercises
3. Use your fork, develop code, push it back upward
4. Profit!

## The First Lesson

Like everything else in the world, these exercises have errors and problems and typos. We experience this problem whenever we code, and the only way to stay sane as a group is to fix problems as we find them. Be a mensch, send pull requests.

--------------------

# Level Up
#### Colleen Sain
----------


## UNIX

Transferring Files Between Boxes

```
$ gem env | grep 'RUBY EXECUTABLE’
```


#### SSH Into VM (secure shell)

**SSH** - “secure shell”, general protocol

**ssh** - linux SSH client command 

```
$ ssh cnuapp@local.dev.cashnetusa.com
```
password: cnuapp

#### Copy files (secure copy)

```
$ scp ../csain.txt cnuapp@local.dev.cashnetusa.com:/home/cnuapp
```

```
$ du -h | sort -n
```

[HTOP](http://www.thegeekstuff.com/2011/09/linux-htop-examples/)

#### Permissions

Changing permissions
see permissions `$ ls -l`
change owner `$ chown`
change group `$ chgrp`
change permissions `$ chmod` (permissions)

#### Ports
list all ports `$ netstat -a | more`

list all tcp ports `$ netstat -at`

list all udp ports `$ netstat -au`

all listening ports `$ netstat -l`

tcp listening ports `$ netstat -lt`

udp listening ports `$ netstat -lu`

unix listening ports `$ netstat -lx`

port statistics `$ netstat -s`

display pid `$ netstat -pt`

Defaults

```
SSH - 22 (file transfers scp, sftp)
HTTP - 80
HTTPS - 443
POSTGRES - 5432
```

#### Processes
currently running `$ ps -ef`

-e all

-f full format

processes by uid for user csain for command-name `$ ps -f -u csain,postfix | grep command-name`

```
$ ps
$ kill -9 [pid]
```

#### Starting & Stopping Services
[Debian](http://oreilly.com/openbook/debian/book/ch07_03.html)

cnuapp@local:~$ `sudo apt-get install openssh-server`

Restart sshd

```
[15:15:14]cnuapp@local:~$ sudo /etc/init.d/ssh start
Starting OpenBSD Secure Shell server: sshd.
[15:15:24]cnuapp@local:~$ sudo /etc/init.d/ssh stop
Stopping OpenBSD Secure Shell server: sshd.
```



Init script to see valid choices (after changing nginx config and want to reload changes without stopping service all together)

```
[15:15:45]cnuapp@local:~$ sudo /etc/init.d/ssh
Usage: /etc/init.d/ssh {start|stop|reload|force-reload|restart|try-restart|status}.
```

#### Monitoring Production Hardware

[Zenoss Network Monitoring](https://www.youtube.com/watch?v=UjJKpDLYx18)
[System monitoring with Zenoss takes complexity out of configuration](http://www.techrepublic.com/blog/linux-and-open-source/system-monitoring-with-zenoss-takes-complexity-out-of-configuration/)
Zenoss uses SNMP to "auto-configure" hosts
SNMP (Simple Network Management Protocol) is an Internet-standard protocol for managing devices on IP networks.

Name some resources that you might monitor for a production host.

* routers
* switches 
* firewalls
* devices
* applications
* servers



(cisco, juniper)


There's a big problem with most monitoring: a momentary spike in resource usage isn't actually a problem. Some software, like the 'god' gem, tries to overcome this limitation. Can you think of some strategies to solve this problem?


## Web Proxies
Usually have a proxy setup to listen for the machine and proxy requests back to actual software

**Proxy server** - a server that acts as an intermediary from clients seeking resources from other services. 
Client connects to proxy server (requesting some service - file/connection/webpage/etc.), proxy evluates request as a way to simplify and controls its complexity

Why use them?

* Adds stucture and encapsulation to distributed systems
* Allows client computers to make indirect network connections to other network services
* Share internet connection on local area network
* Hide IP address
* Implement internet access control
* Access blocked websites
* Speed up internet surfing

Proxies between a production customer and actual application

```
Production   ----- request ---->     Proxy     ----- request ---->    Web
Customer     <---- response ----     Server    <---- response ----    server
```


## Managing Server Time (NTP)
command to reset your time using an external NTP (network time protocol) server

```
ntpdate
```

## Firewalls, iptables, and nmap
Limit traffic in and out of systems using a firewall 

* allowing only whitelisted traffic to pass, we can eliminate large numbers of security vulnerabilities

iptables to manage traffic

* IPTables is a front-end tool to talk to the kernel and decides the packets to filter


init script to start|stop|restart and save rulesets `$ /etc/init.d/iptables`

where Rulesets are saved `$ /etc/sysconfig/iptables`

binary `$ /sbin/iptables`



Start Iptable Firewall: 
```
$ /etc/init.d/iptables start 
```

Check status:
```
$ iptables -L -n -v
```


nmap to scan the machine and display a report of all ports open and listening

## Git
compare staged commits `$ git diff —staged`

and unstage them `$ git reset filename.txt 	` 

## Ruby Core

####Non-gsub method

```
"hello".tr('el', 'ip’)
```




## Additional Topics
Virtual Machine

**Daemon (system service)** - a computer program which runs a background process, rather than being under direct control of an interactive user

* Usually started during initial boot sequence by Init
* `syslogd` - a daemon that implements the system logging facility
* `sshd` - a daemon that services (listens for and manages) incoming SSH connections
* parent proces of a daemon is (often) `init`



Daemon controls :

```
start: start a service
stop: stop a service
restart: restart a service without reloading its job config file
reload: send a SIGHUP signal to running process
status: return the status of a service
```

nginx