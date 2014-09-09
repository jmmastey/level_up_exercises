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

#### firewalls

* Limit traffic in/out of systems 
* allowing only **whitelisted** traffic to pass, we can eliminate large numbers of security vulnerabilities

#### iptables


* use to manage traffic
* IPTables is a front-end tool to talk to the kernel and decides the packets to filter

```
[09:34:15]cnuapp@local:~$ whereis iptables
iptables: /sbin/iptables /usr/sbin/iptables /usr/share/iptables /usr/share/man/man8/iptables.8.gz
```



`$ /etc/init.d/iptables start` init script to start|stop|restart|save rulesets 

`$ /etc/sysconfig/iptables` where Rulesets are saved 

`$ iptables -L -n -v` check status

`$ /sbin/iptables` binary


Start Iptable Firewall: 

```
$ /etc/init.d/iptables start 
```


#### nmap

* network mapper
* security scanner to display a report of all ports open/listening

## Git
compare staged commits `$ git diff —staged`

and unstage them `$ git reset filename.txt 	` 

## Ruby Core

####Non-gsub method

```
"hello".tr('el', 'ip’)
```

####&-unary operator

* Almost the equivalent of calling `#to_proc` on the object


A block that is passed to the each function on the [1,2,3] Array:

```
[1,2,3].each do |x|
  puts x
end
```

A proc assigned to a variable:
```
k = Proc.new{ |x| puts x }
```

inject/reduce (combine many things into one)

lambda


```
[2] pry(main)> proc { |x| x+x }
=> #<Proc:0x007ff0261839e0@(pry):1>
[3] pry(main)> f = _
=> #<Proc:0x007ff0261839e0@(pry):1>
from (pry):3:in `__pry__'
[5] pry(main)> f.call 1
=> 2
```

Procs, Blocks, & Lambdas, & Closures

Know the difference!

## Additional Topics

### Daemons 
**Daemon (system service)** - a computer program which runs a background process, rather than being under direct control of an interactive user

* Usually started during initial boot sequence by Init
* `syslogd` - a daemon that implements the system logging facility
* `sshd` - a daemon that services (listens for and manages) incoming SSH connections
* parent proces of a daemon is (often) `init`



#### Daemon controls:

```
start: start a service
stop: stop a service
restart: restart a service without reloading its job config file
reload: send a SIGHUP signal to running process
status: return the status of a service
```


### Rubocop

` $ gem install rubocop `

` $ cat .hound.yml `

` $ rubocop -c .hound.yml /dino_catalog `

new branch



### Misc.

nginx

curl

bash

grape

functional langs

thread

concurrency

SICP book, lisp

Virtual Machine


