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


### Web Proxies
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


### Managing Server Time (NTP)
command to reset your time using an external NTP (network time protocol) server

```
ntpdate
```

### Firewalls, iptables, and nmap

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

________________________________________________________



## Git
compare staged commits `$ git diff —staged`

and unstage them `$ git reset filename.txt` 


_________________________________________________________


## Ruby Core

####Non-gsub method

```
"hello".tr('el', 'ip’)
```

__________________________________________________________

## Testing

#### The Testing Mindset

Developers are a tricksey bunch. Name some reasons why you shouldn't just trust the person who wrote the code.

* Could have written it late at night and missed some essential edge cases
* Could have completed it in a rush, sloppily
* Might not have a full understaning of the project

Name some mental pitfalls that you should watch out for when testing code.

* Expect that the code doesn't work properly unless you have tests to back it up

So then, why shouldn't we be satisfied with testing our own code?

* Sometimes we get too focused on the code and need someone to come and test it with another perspective
* Testing our own code will parallel the development we completed and not check for cases we hadn't thought of


#### Red -> Green -> Refactor
Tests read like specifications
>  It's easy to go from tests to production code, but hard to go the other direction. And that implies something fascinating about the tests: The tests are the most important component in the system. They are more important than the production code.

**Red** - Tests have been writted which parallel the specifications for a story/feature. When running the tests before the code is written, they fail (sometimes indicated by the color red)

**Green** - Working code is written to get the tests to pass (indicated by the color green)

**Refactor** - The working code is refactored to be more efficient, optimized, easier to read/understand, more eloquent. Duplications are removed (DRY-ed out).
__________________________________________________________
## Additional Topics


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


