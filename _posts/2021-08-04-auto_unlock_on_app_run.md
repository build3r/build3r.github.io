---
layout: single
title:  "Auto Unlock Android Device on App Deploy"
date: 2021-08-01 14:12:21 PM
toc: true
author_profile: true
toc_label: "Index"
---
### Android Studio Device Unlock 
Save **5 to 36 hours** of development time per year by 5 mins of automation.

### Why?
There are cases when you need to test your app on physical device or even on your personal device. Most of the devices have a lock on it (if not, you should), also the device auto-locks after some time. Its kind of annoying when you deploy the app to a physical device and the device is locked. You also waste time in unlocking the device which can add up if you are deploying the app multiple times.

### Solution
We can automate the device unlock on app deployment by creating a bash script which uses adb to unlock the device and add it to our run configuration.  

**Step 1: Create Script**   
Copy the script code below and create a file named "device_awake.sh"  
or   
download the script directly [device_awake.sh]({{ site.url }}/assets/files/device_awake.sh) do not forget to give execute permissions 

```chmod +x ./path/device_awake.sh```  

```bash 
#!/bin/bash
# When a device is attached there will be atleast 3 lines -> heading, device details, an empty new line
if adb devices | wc -l | grep "3"; then 
  # Check if device locked, this may differ on some OEMs
  if adb shell dumpsys window | grep  "mInputRestricted=true"; then 
      echo "Device is Locked"
      adb shell input keyevent KEYCODE_WAKEUP # wakeup device
      adb shell input touchscreen swipe 530 1420 530 1120 # swipe up gesture
      adb shell input text "000000" # <- Change to the your device PIN/Password
      #adb shell input keyevent 66 # simulate press enter, if your keyguard requires it
  else
      echo "Device already unLocked"
  fi
  # 2 = Stay awake on USB, 0 = reset
  adb shell settings put global stay_on_while_plugged_in 2
  #adb shell settings put system screen_brightness 700
  adb shell input keyevent KEYCODE_WAKEUP
  adb shell input touchscreen tap 0 0 # this will wake up the screen and won't have any unwanted touches
else
  echo "There should be only one device connected at a time"
fi

return 0

```

**Step 2: Add it to run configuration**
1. Go to Run/Debug configuration -> Edit Configuration  
![edit_config](/assets/images/edit_config.png)  


2. Create a new Shell Script configuration  
![shell_config](/assets/images/shell_config.png)

3. Add the script path and finalize the shell script configuration  
![script_setup](/assets/images/script_setup.png)

4. Go to app configuartion, scroll to bottom and find "Before Launch" section. Click **+** -> "Run another configuartion" and select the shell script config added in above step  
![before_launch](/assets/images/before_launch.png)

5. Click Apply -> Ok.

Next time when you run the app the device will be automatically unlocked.


### Results
I have been using this from past 1 year. Given that I deploy app around 25-50 times a day during active development the amount of time saving is considerable.  

Here is a quick calculation  
deployment_per_day = 25-50  
time_taken_to_unlock = 3-10 secs (3s if using fingerprint)  
num_dev_days_in_year = 5*52 = 260  

time_saved_in_a_year = deployment_per_day * time_taken_to_unlock *num_dev_days_in_year  

minmum_time_saved_in_a_year = 25 * 3 * 260 = **19,500 secs = 325 mins = 5 hours 25 mins**

maximum_time_saved_in_a_year = 50 * 10 * 260 = **1,30,000 secs = 2,166.66 mins = 36 hours 6 mins**

Just with a 5 minutes of automation we can save around **5-36 hours** of our development time plus it looks cool 😎.
