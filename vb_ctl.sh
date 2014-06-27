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
	   else
		    remote_vm "runningvms" "stop" "running" "-s" "controlvm" "savestate"    
	   fi	        
      ;;
      -b|--begin)
	    if [[  "$kommand" == "" ]]  
	    then
		      local_vm "vms" "start" "existing" "-b" "startvm" ""
	    else
		      remote_vm "vms" "start" "existing" "-b" "startvm" ""		  
	    fi	  
      ;;
      -p|--pause)
       if [[  "$kommand" == "" ]]  
       then
		  local_vm "runningvms" "pause" "running" "-p" "controlvm" "pause"
       else
		remote_vm "runningvms" "pause" "running" "-p" "controlvm" "pause"
       fi      
      ;;
      -r|--resume)
      if [[  "$kommand" == "" ]]  
      then
		  local_vm "runningvms" "resume" "running" "-r" "controlvm" "resume"
      else
		  remote_vm "runningvms" "resume" "running" "-r" "controlvm" "resume"
      fi	  
      ;;
      -c|--clone)
      if [[  "$kommand" == "" ]]  
      then
			    local_vm "vms" "clone" "existing" "-c" "clonevm" "--register"
      else
			   remote_vm  "vms" "clone" "existing" "-c" "clonevm" "--register"
      fi	   
      ;;
      -d|--delete)
       if [[  "$kommand" == "" ]]  
       then
			  local_vm "vms" "delete" "existing" "-d" "unregistervm" "--delete"
       else
			  remote_vm "vms" "delete" "existing" "-d" "unregistervm" "--delete"
       fi	    
      ;;
      -i|--info)	    
	    if [[  "$kommand" == "" ]]  
	    then
		    local_vm "vms" "find info about" "existing" "-i" "showvminfo" ""
	    else
		    remote_vm "vms" "find info about" "existing" "-i" "showvminfo" ""		        
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

