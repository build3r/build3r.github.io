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