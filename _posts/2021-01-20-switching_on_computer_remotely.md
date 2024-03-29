---
layout: single
title:  "Switching On a local/remote PC via terminal"
date:   2021-01-23 19:45:46 +0530
toc: true
author_profile: true
toc_label: "Index"
---
Steps to setup wake up on lan on a remote PC 

[Just show me solution](#solution)

### Setup
I have a local PC with a GPU which I use to run machine Learning models and some heavy processing (building release version of Android App). It only has a LAN port and is kept near to the router which is not next to my working desk. I us ethis system via ssh into it and **shut it down** when i'm not using it (save energy).
### Problem
I have to move my chair or get up and go to the system(5 steps way) to switch it on and I'm nor thrilled to do that plus I can't automate stuff vai tasker or IFTT due a physical step.  
### Solution
I observed that even when I shutdown the system the LED on the LAN port was glowing and after doing some research found that we can switch on the system remotely even if it is off.  
**Wake on Lan (WOL) to the Rescue**  
Using Wake on Lan you can switch on a system even when it is turned off. Given its plugged in and connected to the router/switch.

**Server/PC configuration: Ubuntu 18.04 LTS**
1. ```ip a``` //get the ip broadcast and mac address for the interface ex: eno1 in my case
2. ```sudo ethtool -s eno1 wol g```   //if not installed get it from apt
3. Create a service for WOL so that it persists across restarts
    1. `cd /etc/systemd/system`
    2. `sudo vi wol.service`  
    use the code below replace eno1 with the correct interface name
        ```
        [Unit] 
        Description=Configure Wake-up on LAN
        [Service]
        Type=oneshot
        ExecStart=/sbin/ethtool -s eno1 wol g 
        [Install]
        WantedBy=basic.target
        ```
    3. Make the Service start with system 
        ```
        systemctl daemon-reload
        systemctl enable wol.service
        systemctl start wol.service
        ```

**On the Laptop or other PC side**  
I use MacBook so I installed `wakeonlan` from homebrew to send the magic packet to wake the system. There are multiple tools for systems and even simple python script which do the same.

1. Install wakeon lan  
 ```brew install wakeonlan```
2. run the command  
```wakeonlan -i 192.168.0.255 -p 7 xx:xx:xx:xx:xx:xx```
3. Optional add the above to an alias to make it easy to use

Note: 
- IP is **not** the system IP instead it is the broadcast address
- port is by default 7
- xx:xx:xx:xx:xx:xx = mac address of the remote system

### Conclusion
Thats it, now I can sit on my chair for hours together. Which in the hindsight is not good for my back.

Resources:
1. [blog.yucas.net](https://blog.yucas.net/2019/05/03/setting-up-wake-on-lan-on-ubuntu-server-18-04-lts/)
2. [apple.stackexchange.com](https://apple.stackexchange.com/questions/95246/wake-other-computers-from-mac-osx)