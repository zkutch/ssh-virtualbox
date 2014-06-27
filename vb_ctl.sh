#/bin/bash!
#

local_vm() 
# running_type=runningvms|vms action_name=stop|.. vm_type=running|.. option_name=-s|.. operator_before=controlvm|.. operator_after=savestate|
{
		    raod=`VBoxManage list $1 | wc -l`
		    if [ $raod -eq 0 ]
		    then
		      echo You have not running virtual machines to "$2".
		      echo	    
		    else
			key1=${my_options[$i+1]}
			if [[ "$key1" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
			then
			    if [[ "$key1" -gt "$raod" ]]
			    then
				echo Chosed virtual machine number "$key1" is more then "$3" virtual machines amount "$raod". Exit.
				echo
				exit 3
			    else
				echo Try to "$2" number "$key1" virtual machine from list.
				VBoxManage list $1 | nl
				num=`VBoxManage list $1 | sed -n "$key1"p | awk -F '"' '{print $2}' | sed 's/"//g'`
				echo "$2" "$num" ..
				if [ "$6" == ""  ]
				then
				  VBoxManage $5 "$num"
				else
				  VBoxManage $5 "$num" $6
				fi
				
				echo		  
			    fi		  
			else
			    echo After "$4" option should be number of virtual machine
			    echo
			    exit 2;
			fi  
		    fi	
}

remote_vm()
# running_type=runningvms|vms action_name=stop|.. vm_type=running|.. option_name=-s|.. operator_before=controlvm|.. operator_after=savestate|
{

			kom2s=\''raod8s=$(VBoxManage list $1 |  wc -l); echo "$raod8s"'\'
			raod10s=$(eval "$kommand  $kom2s")
			if [ $raod10s -eq 0 ]
			  then
			    echo You have not  running virtual machines to "$2" .
			    echo	    
			  else
			      key7s=${my_options[$i+1]}
			      if [[ "$key7s" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
			      then
				  if [[ "$key7s" -gt "$raod10s" ]]
				  then
				      echo Chosed virtual machine number "$key7s" is more then "$3" virtual machines amount "$raod10s". Exit.
				      echo
				      exit 3
				  else
				      echo Try to "$2" number $key7s virtual machine from list.
				      kom3s='VBoxManage list $1 | nl'
				      eval "$kommand $kom3s"
				      num=$( eval "$kommand $kom3s" | sed -n "$key7s"p | awk -F '"' '{print $2}' )
				      echo "$2" "$num" ..
				      if [ "$6" == ""  ]
				      then
					kom4s='VBoxManage $5 "$num"  &'
				      else
					kom4s='VBoxManage $5 "$num" $6  &'
				      fi				      
				      eval "$kommand $kom4s" 				    
				      echo		  
				  fi		  
			      else
				  echo After "$4" option should be number of virtual machine
				  echo
				  exit 2;
			      fi  
			  fi

}

echo
if [ $# -eq 0 ]
then
  echo "Nothing to do without options. Exit."
  echo
  exit 1
fi

my_options=("$@")
kommand=""
Xwin=""

for (( i=0; i<$#; i++ ))
do
   key=${my_options[$i]}

   case $key in
       -X|--Xwindow)
	    Xwin='-X'
	;;
       -R|--Remote)
	  key8=${my_options[$i+1]}
	  if [[ "$key8" =~ ^.*@.*$ ]]
	  then
	      kommand="ssh $Xwin $key8"
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
      -L|--List)
	  echo List all  currently running virtual machines.
	  echo
	  kom1='VBoxManage list runningvms | nl'
	  eval "$kommand $kom1"
	  echo
      ;;
      -s|--stop)
	   if [[  "$kommand" == "" ]]  
	   then
		    local_vm "runningvms" "stop" "running" "-s" "controlvm" "savestate"
# 		    raod=`VBoxManage list runningvms | wc -l`
# 		    if [ $raod -eq 0 ]
# 		    then
# 		      echo "You have not running virtual machines to stop."
# 		      echo	    
# 		    else
# 			key1=${my_options[$i+1]}
# 			if [[ "$key1" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 			then
# 			    if [[ "$key1" -gt "$raod" ]]
# 			    then
# 				echo "Chosed virtual machine number $key1 is more then running virtual machines amount $raod. Exit."
# 				echo
# 				exit 3
# 			    else
# 				echo Try to stop number $key1 virtual machine from list.
# 				VBoxManage list runningvms | nl
# 				num=`VBoxManage list runningvms | sed -n "$key1"p | awk -F '"' '{print $2}' | sed 's/"//g'`
# 				echo stopping "$num" ..
# 				VBoxManage controlvm "$num" savestate
# 				echo		  
# 			    fi		  
# 			else
# 			    echo After -s option should be number of virtual machine
# 			    echo
# 			    exit 2;
# 			fi  
# 		    fi	
	   else
		    remote_vm "runningvms" "stop" "running" "-s" "controlvm" "savestate"
# 		    kom2s=\''raod8s=$(VBoxManage list runningvms |  wc -l); echo "$raod8s"'\'
# 			raod10s=$(eval "$kommand  $kom2s")
# 			if [ $raod10s -eq 0 ]
# 			  then
# 			    echo "You have not  running virtual machines to stop ."
# 			    echo	    
# 			  else
# 			      key7s=${my_options[$i+1]}
# 			      if [[ "$key7s" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 			      then
# 				  if [[ "$key7s" -gt "$raod10s" ]]
# 				  then
# 				      echo "Chosed virtual machine number $key7s is more then existing virtual machines amount $raod10s. Exit."
# 				      echo
# 				      exit 3
# 				  else
# 				      echo Try to stop number $key7s virtual machine from list.
# 				      kom3s='VBoxManage list runningvms | nl'
# 				      eval "$kommand $kom3s"
# 				      num=$( eval "$kommand $kom3s" | sed -n "$key7s"p | awk -F '"' '{print $2}' )
# 				      echo stopping "$num" ..
# 				      kom4s='VBoxManage controlvm "$num" savestate  &'
# 				      eval "$kommand $kom4s" 				    
# 				      echo		  
# 				  fi		  
# 			      else
# 				  echo After -s option should be number of virtual machine
# 				  echo
# 				  exit 2;
# 			      fi  
# 			  fi
	   fi
	        
      ;;
      -b|--begin)
	    if [[  "$kommand" == "" ]]  
	    then
		      local_vm "vms" "start" "existing" "-b" "startvm" ""
# 		      raod1=`VBoxManage list vms | wc -l`
# 		      if [ $raod1 -eq 0 ]
# 			then
# 			  echo "You have not virtual machines to start."
# 			  echo	    
# 			else
# 			    key2=${my_options[$i+1]}
# 			    if [[ "$key2" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 			    then
# 				if [[ "$key2" -gt "$raod1" ]]
# 				then
# 				    echo "Chosed virtual machine number $key2 is more then existing virtual machines amount $raod1. Exit."
# 				    echo
# 				    exit 3
# 				else
# 				    echo Try to start number $key2 virtual machine from list.
# 				    VBoxManage list vms | nl
# 				    num=`VBoxManage list vms | sed -n "$key2"p | awk -F '"' '{print $2}' | sed 's/"//g'`
# 				    echo starting "$num" ..
# 				    VBoxManage startvm "$num" 
# 				    echo		  
# 				fi		  
# 			    else
# 				echo After -b option should be number of virtual machine
# 				echo
# 				exit 2;
# 			    fi  
# 			fi
	    else
			kom2b=\''raod8b=$(VBoxManage list vms |  wc -l); echo "$raod8b"'\'
			raod10b=$(eval "$kommand  $kom2b")
			if [ $raod10b -eq 0 ]
			  then
			    echo "You have not virtual machines to start ."
			    echo	    
			  else
			      key7b=${my_options[$i+1]}
			      if [[ "$key7b" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
			      then
				  if [[ "$key7b" -gt "$raod10b" ]]
				  then
				      echo "Chosed virtual machine number $key7b is more then existing virtual machines amount $raod10b. Exit."
				      echo
				      exit 3
				  else
				      echo Try to find number $key7b virtual machine from list.
				      kom3b='VBoxManage list vms | nl'
				      eval "$kommand $kom3b"
				      num=$( eval "$kommand $kom3b" | sed -n "$key7b"p | awk -F '"' '{print $2}' )
				      echo starting "$num" ..
				      kom4b='VBoxManage startvm "$num" &'
				      eval "$kommand $kom4b" 				    
				      echo		  
				  fi		  
			      else
				  echo After -b option should be number of virtual machine
				  echo
				  exit 2;
			      fi  
			  fi
		  
	    fi
	     	 	 
	  
      ;;
      -p|--pause)
       if [[  "$kommand" == "" ]]  
       then
		  local_vm "runningvms" "pause" "running" "-p" "controlvm" "pause"
# 		  raod3=`VBoxManage list runningvms | wc -l`
# 		  if [ $raod3 -eq 0 ]
# 		  then
# 		    echo "You have not running virtual machines to pause."
# 		    echo	    
# 		  else
# 		      key3=${my_options[$i+1]}
# 		      if [[ "$key3" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 		      then
# 			  if [[ "$key3" -gt "$raod3" ]]
# 			  then
# 			      echo "Chosed virtual machine number $key3 is more then running virtual machines amount $raod3. Exit."
# 			      echo
# 			      exit 3
# 			  else
# 			      echo Try to pause number $key3 virtual machine from list.
# 			      VBoxManage list runningvms | nl
# 			      num=`VBoxManage list runningvms | sed -n "$key3"p | awk -F '"' '{print $2}' | sed 's/"//g'`
# 			      echo start pausing "$num" ..
# 			      VBoxManage controlvm "$num" pause
# 			      echo		  
# 			  fi		  
# 		      else
# 			  echo After -p option should be number of virtual machine
# 			  echo
# 			  exit 2;
# 		      fi  
# 		  fi	

       else
		kom2b=\''raod8b=$(VBoxManage list runningvms |  wc -l); echo "$raod8b"'\'
			raod10b=$(eval "$kommand  $kom2b")
			if [ $raod10b -eq 0 ]
			  then
			    echo "You have not virtual machines to pause ."
			    echo	    
			  else
			      key7b=${my_options[$i+1]}
			      if [[ "$key7b" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
			      then
				  if [[ "$key7b" -gt "$raod10b" ]]
				  then
				      echo "Chosed virtual machine number $key7b is more then running virtual machines amount $raod10b. Exit."
				      echo
				      exit 3
				  else
				      echo Try to pause number $key7b virtual machine from list.
				      kom3b='VBoxManage list runningvms | nl'
				      eval "$kommand $kom3b"
				      num=$( eval "$kommand $kom3b" | sed -n "$key7b"p | awk -F '"' '{print $2}' )
				      echo start pausing "$num" ..
				      kom4b='VBoxManage controlvm "$num" pause  &'
				      eval "$kommand $kom4b" 				    
				      echo		  
				  fi		  
			      else
				  echo After -p option should be number of virtual machine
				  echo
				  exit 2;
			      fi  
			  fi

       fi      
      ;;
      -r|--resume)
      if [[  "$kommand" == "" ]]  
      then
		  local_vm "runningvms" "resume" "running" "-r" "controlvm" "resume"
# 		  raod4=`VBoxManage list runningvms | wc -l`
# 		  if [ $raod4 -eq 0 ]
# 		  then
# 		    echo "You have not running virtual machines to resume."
# 		    echo	    
# 		  else
# 		      key4=${my_options[$i+1]}
# 		      if [[ "$key4" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 		      then
# 			  if [[ "$key4" -gt "$raod4" ]]
# 			  then
# 			      echo "Chosed virtual machine number $key4 is more then running virtual machines amount $raod4. Exit."
# 			      echo
# 			      exit 3
# 			  else
# 			      echo Try to resume number $key4 virtual machine from list.
# 			      VBoxManage list runningvms | nl
# 			      num=`VBoxManage list runningvms | sed -n "$key4"p | awk -F '"' '{print $2}' | sed 's/"//g'`
# 			      echo start resuming "$num" ..
# 			      VBoxManage controlvm "$num" resume
# 			      echo		  
# 			  fi		  
# 		      else
# 			  echo After -r option should be number of virtual machine
# 			  echo
# 			  exit 2;
# 		      fi  
# 		  fi		

      else
		 kom2b=\''raod8b=$(VBoxManage list runningvms |  wc -l); echo "$raod8b"'\'
			raod10b=$(eval "$kommand  $kom2b")
			if [ $raod10b -eq 0 ]
			  then
			    echo "You have not virtual machines to resume ."
			    echo	    
			  else
			      key7b=${my_options[$i+1]}
			      if [[ "$key7b" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
			      then
				  if [[ "$key7b" -gt "$raod10b" ]]
				  then
				      echo "Chosed virtual machine number $key7b is more then running virtual machines amount $raod10b. Exit."
				      echo
				      exit 3
				  else
				      echo Try to resume number $key7b virtual machine from list.
				      kom3b='VBoxManage list runningvms | nl'
				      eval "$kommand $kom3b"
				      num=$( eval "$kommand $kom3b" | sed -n "$key7b"p | awk -F '"' '{print $2}' )
				      echo start resuming "$num" ..
				      kom4b='VBoxManage controlvm "$num" resume  &'
				      eval "$kommand $kom4b" 				    
				      echo		  
				  fi		  
			      else
				  echo After -r option should be number of virtual machine
				  echo
				  exit 2;
			      fi  
			  fi

      fi
	  
      ;;
      -c|--clone)
      if [[  "$kommand" == "" ]]  
      then
			    local_vm "vms" "clone" "existing" "-c" "clonevm" "--register"
# 			    raod5=`VBoxManage list vms | wc -l`
# 			    if [ $raod5 -eq 0 ]
# 			      then
# 				echo "You have not virtual machines to clone."
# 				echo	    
# 			      else
# 				  key5=${my_options[$i+1]}
# 				  if [[ "$key5" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 				  then
# 				      if [[ "$key5" -gt "$raod5" ]]
# 				      then
# 					  echo "Chosed virtual machine number $key5 is more then existing virtual machines amount $raod5. Exit."
# 					  echo
# 					  exit 3
# 				      else
# 					  echo Try to clone number $key5 virtual machine from list.
# 					  VBoxManage list vms | nl
# 					  num=`VBoxManage list vms | sed -n "$key5"p | awk -F '"' '{print $2}' | sed 's/"//g'`
# 					  echo clone "$num" ..
# 					  VBoxManage clonevm "$num" --register
# 					  echo		  
# 				      fi		  
# 				  else
# 				      echo After -c option should be number of virtual machine
# 				      echo
# 				      exit 2;
# 				  fi  
# 			      fi	  

      else
			      kom2b=\''raod8b=$(VBoxManage list vms |  wc -l); echo "$raod8b"'\'
			      raod10b=$(eval "$kommand  $kom2b")
			      if [ $raod10b -eq 0 ]
				then
				  echo "You have not virtual machines to clone ."
				  echo	    
				else
				    key7b=${my_options[$i+1]}
				    if [[ "$key7b" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
				    then
					if [[ "$key7b" -gt "$raod10b" ]]
					then
					    echo "Chosed virtual machine number $key7b is more then existing virtual machines amount $raod10b. Exit."
					    echo
					    exit 3
					else
					    echo Try to find number $key7b virtual machine from list.
					    kom3b='VBoxManage list vms | nl'
					    eval "$kommand $kom3b"
					    num=$( eval "$kommand $kom3b" | sed -n "$key7b"p | awk -F '"' '{print $2}' )
					    echo clone "$num" ..
					    kom4b='VBoxManage clonevm "$num" --register  &'
					    eval "$kommand $kom4b" 				    
					    echo		  
					fi		  
				    else
					echo After -c option should be number of virtual machine
					echo
					exit 2;
				    fi  
				fi

      fi
	   
      ;;
      -d|--delete)
       if [[  "$kommand" == "" ]]  
       then
			  local_vm "vms" "delete" "existing" "-d" "unregistervm" "--delete"
# 			  raod6=`VBoxManage list vms | wc -l`
# 			  if [ $raod6 -eq 0 ]
# 			    then
# 			      echo "You have not virtual machines to delete."
# 			      echo	    
# 			    else
# 				key6=${my_options[$i+1]}
# 				if [[ "$key6" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 				then
# 				    if [[ "$key6" -gt "$raod6" ]]
# 				    then
# 					echo "Chosed virtual machine number $key6 is more then existing virtual machines amount $raod6. Exit."
# 					echo
# 					exit 3
# 				    else
# 					echo Try to delete number $key6 virtual machine from list.
# 					VBoxManage list vms | nl
# 					num=`VBoxManage list vms | sed -n "$key6"p | awk -F '"' '{print $2}' | sed 's/"//g'`
# 					echo delete "$num" ..
# 					VBoxManage unregistervm "$num" --delete
# 					echo		  
# 				    fi		  
# 				else
# 				    echo After -d option should be number of virtual machine
# 				    echo
# 				    exit 2;
# 				fi  
# 			    fi	 	

       else
			   kom2b=\''raod8b=$(VBoxManage list vms |  wc -l); echo "$raod8b"'\'
			      raod10b=$(eval "$kommand  $kom2b")
			      if [ $raod10b -eq 0 ]
				then
				  echo "You have not virtual machines to delete ."
				  echo	    
				else
				    key7b=${my_options[$i+1]}
				    if [[ "$key7b" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
				    then
					if [[ "$key7b" -gt "$raod10b" ]]
					then
					    echo "Chosed virtual machine number $key7b is more then existing virtual machines amount $raod10b. Exit."
					    echo
					    exit 3
					else
					    echo Try to find number $key7b virtual machine from list.
					    kom3b='VBoxManage list vms | nl'
					    eval "$kommand $kom3b"
					    num=$( eval "$kommand $kom3b" | sed -n "$key7b"p | awk -F '"' '{print $2}' )
					    echo delete "$num" ..
					    kom4b='VBoxManage unregistervm "$num" --delete  &'
					    eval "$kommand $kom4b" 				    
					    echo		  
					fi		  
				    else
					echo After -d option should be number of virtual machine
					echo
					exit 2;
				    fi  
				fi

       fi
	    
      ;;
      -i|--info)	    
	    if [[  "$kommand" == "" ]]  
	    then
		    local_vm "vms" "find info about" "existing" "-i" "showvminfo" ""
# 		    raod7=$(VBoxManage list vms | sed -n "$=")
# 		      if [ $raod7 -eq 0 ]
# 			then
# 			  echo "You have not virtual machines."
# 			  echo	    
# 			else
# 			    key7=${my_options[$i+1]}
# 			    if [[ "$key7" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
# 			    then
# 				if [[ "$key7" -gt "$raod7" ]]
# 				then
# 				    echo "Chosed virtual machine number $key7 is more then existing virtual machines amount $raod7. Exit."
# 				    echo
# 				    exit 3
# 				else
# 				    echo Try to find number $key7 virtual machine from list.
# 				    VBoxManage list vms | nl
# 				    num=`VBoxManage list vms | sed -n "$key7"p | awk -F '"' '{print $2}' | sed 's/"//g'`
# 				    echo showing info for "$num" ..
# 				    VBoxManage showvminfo "$num"
# 				    echo		  
# 				fi		  
# 			    else
# 				echo After -i option should be number of virtual machine
# 				echo
# 				exit 2;
# 			    fi  
# 			fi	   
	    else
		      kom2=\''raod8=$(VBoxManage list vms |  wc -l); echo "$raod8"'\'
		      raod10=$(eval "$kommand  $kom2")
		      if [ $raod10 -eq 0 ]
			then
			  echo "You have not virtual machines."
			  echo	    
			else
			    key7=${my_options[$i+1]}
			    if [[ "$key7" =~ ^[1-9]+[0-9]?$ ]] #2>/dev/null	  
			    then
				if [[ "$key7" -gt "$raod10" ]]
				then
				    echo "Chosed virtual machine number $key7 is more then existing virtual machines amount $raod10. Exit."
				    echo
				    exit 3
				else
				    echo Try to find number $key7 virtual machine from list.
				    kom3='VBoxManage list vms | nl'
				    eval "$kommand $kom3"
				    num=$( eval "$kommand $kom3" | sed -n "$key7"p | awk -F '"' '{print $2}' )
				    echo showing info for "$num" ..
				    kom4='VBoxManage showvminfo "$num"'
				    eval "$kommand $kom4" 				    
				    echo		  
				fi		  
			    else
				echo After -i option should be number of virtual machine
				echo
				exit 2;
			    fi  
			fi	   
	    fi
	 
      ;;
      -h|--help)
	  echo
	  echo "	vb_ctl.sh little script to manage VirtualBox machines locally and remotely."
	  echo "	Following options are supported:"
	  echo "	 -d|--delete. Delete specific virtual machine, after -d must number of vm from existing virtual machines list."
	  echo "	 -c|--clone. Clone (and --register) specific virtual machine, after -c must number of vm from existing virtual machines list. "
	  echo "	 -r|--resume. Resume specific virtual machine, after -r must number of vm from running virtual machines list."
	  echo "	 -p|--pause. Pause specific virtual machine, after -p must number of vm from running virtual machines list."
	  echo "	 -s|--stop. Stops=savestate  specific virtual machine, after -s must number of vm from running virtual machines list."
	  echo "	 -b|--begin. Begins specific virtual machine, after -b must number of vm from existing virtual machines list."
	  echo "	 -l|--list. List all existing virtual machines."	  
	  echo "	 -i|--info. Shows info about specific virtual machine, after -i must number of vm from existing virtual machines list."
	  echo "	 -R|--Remote. Script works on remote host, after -R must be remote_user@remote_host, all options after -R applied remotely."
	  echo "	 -X|--Xwindow. Turns on -X option for ssh, must be before option -R."
	  echo "	 -L|--List. List all currently running virtual machines."	  
	  echo	  
      ;;
     
   esac
done




exit 0
echo

