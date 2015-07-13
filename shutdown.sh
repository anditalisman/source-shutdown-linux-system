if [-n "`ps ax | grep shutdown | egrep -v 'grep | shutdown-timer'`"]; then
  zenity --title="Time Shutdown" --question --text="Cancel Shutdown Timer?"
    if ["$?" == "0"]; then
      sudo shutdown -c
      if ["$?" == "0"]; then
        zenity --title="Time Shutdown" --info --text="Shutdown cancelled."
      else
	PASSWORD=`zenity --title='Time Shutdown' --entry --text='Please enter your password : ' --hide-text`
	if [ -n "$PASSWORD" ]; then
	  echo $PASSWORD | sudo -S shutdown -c
	   if ["$?" == "0"]; then
	     zenity --title="Time Shutdown" --info --text="Shutdown cancelled."
	   else
	    zenity --title="Time Shutdown" --error --text="Sorry, wrong password!"
	   fi
        fi
     fi
  fi
else
  TIMER=$(zenity --title="Time Shutdown" --scale --text="Atur Waktu Shutdown : " --value=30 --min-value=0 --max-value=180 --step=5)
     if [ -n "$TIMER" ]; then
	sudo -b shutdown -h +$TIMER
	if ["?" == "0"]; then
	  zenity --title="Time Shutdown" --info --text="Shutdown in $TIMER minutes!"
	else
	  PASSWORD=`zenity --title='Time Shutdown' --entry --text='Please enter your password : ' --hide-text`
	    if [ -n "$PASSWORD" ]; then
		echo $PASSWORD | sudo -Sb shutdown -h +$TIMER
		if ["$?" == "0"]; then
		  zenity --title="Time Shutdown" --info --text="Shutdown in $TIMER minutes!"
		else
		  zenity --title="Time Shutdown" --error --text="Sorry, wrong password!"
		fi
	    fi
	fi
    fi
fi