#/bin/bash!
#
echo
if [ $# -eq 0 ]
then
  echo "Nothing to do without options. Exit."
  echo
  exit 1
fi

my_options=("$@")
kommand=""

for (( i=0; i<$#; i++ ))
do
   key=${my_options[$i]}
   
   case $key in
       -R|--Remote)
	  key7=${my_options[$i+1]}
	  if [[ "$key7" =~ ^.*@.*$ ]]
	  then
	      kommand="ssh -T $key7"
	  else
	       echo After -R option should be remote_user@remote_host
	       echo
	       exit 4
	  fi
      ;;
      -l|--list)
	  echo List all virtual machines currently registered with VirtualBox.
	  echo
	  kom1='VBoxManage list vms | nl'
	  eval "$kommand $kom1"
	  echo
      ;;
      -s|--stop)
	  raod=`VBoxManage list runningvms | wc -l`
	  if [ $raod -eq 0 ]
	  then
	    echo "You have not running virtual machines to stop."
	    echo	    
	  else
	      key1=${my_options[$i+1]}
	      if [[ "$key1" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
	      then
		  if [[ "$key1" -gt "$raod" ]]
		  then
		      echo "Chosed virtual machine number $key1 is more then running virtual machines amount $raod. Exit."
		      echo
		      exit 3
		   else
		      echo Try to stop number $key1 virtual machine from list.
		      VBoxManage list runningvms
		      num=`VBoxManage list runningvms | sed -n "$key1"p | awk -F '"' '{print $2}' | sed 's/"//g'`
		      echo stopping "$num" ..
		      VBoxManage controlvm "$num" savestate
		       echo		  
		  fi		  
	      else
		  echo After -s option should be number of virtual machine
		  echo
		  exit 2;
	      fi  
	  fi	      
      ;;
      -b|--begin)
	  if [[  "$kommand" == "" ]]  
	  then
	      raod1=`VBoxManage list vms | wc -l`
	      if [ $raod1 -eq 0 ]
		then
		  echo "You have not virtual machines to start."
		  echo	    
		else
		    key2=${my_options[$i+1]}
		    if [[ "$key2" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
		    then
			if [[ "$key2" -gt "$raod1" ]]
			then
			    echo "Chosed virtual machine number $key2 is more then existing virtual machines amount $raod1. Exit."
			    echo
			    exit 3
			else
			    echo Try to start number $key2 virtual machine from list.
			    VBoxManage list vms | nl
			    num=`VBoxManage list vms | sed -n "$key2"p | awk -F '"' '{print $2}' | sed 's/"//g'`
			    echo starting "$num" ..
			    VBoxManage startvm "$num" 
			    echo		  
			fi		  
		    else
			echo After -b option should be number of virtual machine
			echo
			exit 2;
		    fi  
		fi	   
	  else	       
	      
	      kom2='raod1=`VBoxManage list vms | wc -l` | echo raod aris $raod1'
	      kom3=' echo raod aris $raod1'
	      #eval "$kommand $kom2"
	     # eval "$kommand $kom3"
	     ssh -T "$key7" << eof
	     raod1=`VBoxManage list vms | wc -l`
	     echo "raod aris  \$raod1"
		    if [[ "$raod1" -eq 0 ]]
		      then
			echo "You have not virtual machines to start."
			echo	    
		      else
			  key2=${my_options[$i+1]}
			  if [[ "$key2" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
			  then
			      if [[ "$key2" -gt "$raod1" ]]
			      then
				  echo "Chosed virtual machine number $key2 is more then existing virtual machines amount $raod1. Exit."
				  echo
				  exit 3
			      else
				  echo Try to start number $key2 virtual machine from list.
				  VBoxManage list vms | nl
				  num=`VBoxManage list vms | sed -n "$key2"p | awk -F '"' '{print $2}' | sed 's/"//g'`
				  echo starting "$num" ..
				  VBoxManage startvm "$num" 
				  echo		  
			      fi		  
			  else
			      echo After -b option should be number of virtual machine
			      echo
			      exit 2;
			  fi  
		      fi
eof
	  fi
	  
      ;;
      -p|--pause)
	  raod3=`VBoxManage list runningvms | wc -l`
	  if [ $raod3 -eq 0 ]
	  then
	    echo "You have not running virtual machines to pause."
	    echo	    
	  else
	      key3=${my_options[$i+1]}
	      if [[ "$key3" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
	      then
		  if [[ "$key3" -gt "$raod3" ]]
		  then
		      echo "Chosed virtual machine number $key3 is more then running virtual machines amount $raod3. Exit."
		      echo
		      exit 3
		   else
		      echo Try to pause number $key3 virtual machine from list.
		      VBoxManage list runningvms
		      num=`VBoxManage list runningvms | sed -n "$key3"p | awk -F '"' '{print $2}' | sed 's/"//g'`
		      echo start pausing "$num" ..
		      VBoxManage controlvm "$num" pause
		       echo		  
		  fi		  
	      else
		  echo After -p option should be number of virtual machine
		  echo
		  exit 2;
	      fi  
	  fi	
      
      ;;
      -r|--resume)
	   raod4=`VBoxManage list runningvms | wc -l`
	  if [ $raod4 -eq 0 ]
	  then
	    echo "You have not running virtual machines to resume."
	    echo	    
	  else
	      key4=${my_options[$i+1]}
	      if [[ "$key4" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
	      then
		  if [[ "$key4" -gt "$raod4" ]]
		  then
		      echo "Chosed virtual machine number $key4 is more then running virtual machines amount $raod4. Exit."
		      echo
		      exit 3
		   else
		      echo Try to resume number $key4 virtual machine from list.
		      VBoxManage list runningvms
		      num=`VBoxManage list runningvms | sed -n "$key4"p | awk -F '"' '{print $2}' | sed 's/"//g'`
		      echo start resuming "$num" ..
		      VBoxManage controlvm "$num" resume
		       echo		  
		  fi		  
	      else
		  echo After -r option should be number of virtual machine
		  echo
		  exit 2;
	      fi  
	  fi	
      ;;
      -c|--clone)
	   raod5=`VBoxManage list vms | wc -l`
	  if [ $raod5 -eq 0 ]
	    then
	      echo "You have not virtual machines to clone."
	      echo	    
	    else
		key5=${my_options[$i+1]}
		if [[ "$key5" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
		then
		    if [[ "$key5" -gt "$raod5" ]]
		    then
			echo "Chosed virtual machine number $key5 is more then existing virtual machines amount $raod5. Exit."
			echo
			exit 3
		    else
			echo Try to clone number $key5 virtual machine from list.
			VBoxManage list vms | nl
			num=`VBoxManage list vms | sed -n "$key5"p | awk -F '"' '{print $2}' | sed 's/"//g'`
			echo clone "$num" ..
			VBoxManage clonevm "$num" --register
			echo		  
		    fi		  
		else
		    echo After -c option should be number of virtual machine
		    echo
		    exit 2;
		fi  
	    fi	   
      ;;
      -d|--delete)
	   raod6=`VBoxManage list vms | wc -l`
	  if [ $raod6 -eq 0 ]
	    then
	      echo "You have not virtual machines to delete."
	      echo	    
	    else
		key6=${my_options[$i+1]}
		if [[ "$key6" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
		then
		    if [[ "$key6" -gt "$raod6" ]]
		    then
			echo "Chosed virtual machine number $key6 is more then existing virtual machines amount $raod6. Exit."
			echo
			exit 3
		    else
			echo Try to delete number $key6 virtual machine from list.
			VBoxManage list vms | nl
			num=`VBoxManage list vms | sed -n "$key6"p | awk -F '"' '{print $2}' | sed 's/"//g'`
			echo delete "$num" ..
			VBoxManage unregistervm "$num" --delete
			echo		  
		    fi		  
		else
		    echo After -d option should be number of virtual machine
		    echo
		    exit 2;
		fi  
	    fi	   
      ;;
       -i|--info)
	  raod7=`VBoxManage list vms | wc -l`
	  if [ $raod7 -eq 0 ]
	    then
	      echo "You have not virtual machines."
	      echo	    
	    else
		key7=${my_options[$i+1]}
		if [[ "$key7" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
		then
		    if [[ "$key7" -gt "$raod7" ]]
		    then
			echo "Chosed virtual machine number $key7 is more then existing virtual machines amount $raod7. Exit."
			echo
			exit 3
		    else
			echo Try to find number $key7 virtual machine from list.
			VBoxManage list vms | nl
			num=`VBoxManage list vms | sed -n "$key7"p | awk -F '"' '{print $2}' | sed 's/"//g'`
			echo showing info for "$num" ..
			VBoxManage showvminfo "$num"
			echo		  
		    fi		  
		else
		    echo After -i option should be number of virtual machine
		    echo
		    exit 2;
		fi  
	    fi	   
      ;;
      -h|--help)
	  echo
	  echo "	vb_ctl.sh little script to manage VirtualBox machines locally and remotely."
	  echo "	Following options are supported:"
	  echo "	 -d|--delete."
	  echo "	 -c|--clone."
	  echo "	 -r|--resume."
	  echo "	 -p|--pause."
	  echo "	 -s|--stop."
	  echo "	 -b|--begin."
	  echo "	 -l|--list."	  
	  echo "	 -i|--info."
	  echo	  
      ;;
     
   esac
done




exit 0
echo



