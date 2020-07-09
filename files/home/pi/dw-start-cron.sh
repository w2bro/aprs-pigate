#!/bin/bash

# Pre-modified version of dw-start.sh for headless CLI setup.
# Original: https://github.com/wb2osz/direwolf/blob/master/dw-start.sh
# Changes:
# - remove RUNMODE to force CLI always (helps for testing), remove GUI function
# - set DWCMD for CLI mode with RTL-SDR, create a separate file to pass to screen to work with Buster
# - remove initial sleep wait since we don't care about desktop
# - added logs to CLI command that pipe to LOGFILE instead of ignored.

# Run this from crontab periodically to start up
# Dire Wolf automatically.

# Location of the direwolf binary.  Depends on $PATH as shown.
# change this if you want to use some other specific location.
# e.g.  DIREWOLF="/usr/local/bin/direwolf"
DIREWOLF="direwolf"

DWCMD="/home/pi/pigate-start.sh"

# Where will logs go - needs to be writable by non-root users
LOGFILE=/var/tmp/dw-start.log

#-------------------------------------
# Main functions of the script
#-------------------------------------
function CLI {
   SCREEN=`which screen`
   if [ $? -ne 0 ]; then
      echo -e "Error: screen is not installed but is required for CLI mode.  Aborting"
      echo -e "Error: screen is not installed but is required for CLI mode.  Aborting" >> $LOGFILE
      exit 1
   fi

   echo "Direwolf in CLI mode start up"
   echo "Direwolf in CLI mode start up" >> $LOGFILE

   # Screen commands
   #  -d m :: starts the command in detached mode
   #  -S   :: name the session
   $SCREEN -L -d -m -S direwolf $DWCMD >> $LOGFILE
   $SCREEN -list direwolf
   $SCREEN -list direwolf >> $LOGFILE

   echo "-----------------------"
   echo "-----------------------" >> $LOGFILE
}

# -----------------------------------------------------------
# Main Script start
# -----------------------------------------------------------

# When running from cron, we have a very minimal environment
# including PATH=/usr/bin:/bin.
#
export PATH=/usr/local/bin:$PATH

#
# Nothing to do if Direwolf is already running.
#
a=`ps ax | grep direwolf | grep -vi -e bash -e screen -e grep | awk '{print $1}'`
if [ -n "$a" ]
then
  #date >> /tmp/dw-start.log
  #echo "Direwolf already running." >> $LOGFILE
  exit
fi

# Main execution of the script
echo "Direwolf not running, starting." >> $LOGFILE
CLI
