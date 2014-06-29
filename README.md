 
 
 
 vb_ctl.sh is little script to manage VirtualBox machines locally and remotely.
        For remote use (option -R)  best is to have public key authentication  with remote host.
        Following options are supported:
         -b|--begin. Begins specific virtual machine, after -b must be number of vm from existing virtual machines list.
         -d|--delete. Delete specific virtual machine, after -d must be number of vm from existing virtual machines list.
         -c|--clone. Clone (and --register) specific virtual machine, after -c must be number of vm from existing virtual machines list. 
         -r|--resume. Resume specific virtual machine, after -r must be number of vm from running virtual machines list.
         -p|--pause. Pause specific virtual machine, after -p must be number of vm from running virtual machines list.
         -s|--stop. Stops=savestate  specific virtual machine, after -s must be number of vm from running virtual machines list.
         -P|--Poweroff. Stops=poweroff  specific virtual machine, after -P must be number of vm from running virtual machines list.
         -t|--turn. Stops=reset  specific virtual machine, after -t must be number of vm from running virtual machines list.
         -l|--list. List all existing virtual machines.
         -L|--List. List all currently running virtual machines.
         -i|--info. Shows info about specific virtual machine, after -i must be number of vm from existing virtual machines list.
         -R|--Remote. Script works on remote host, after -R must be remote_user@remote_host, all options after -R applied remotely.
         -X|--Xwindow. Turns on -X option for ssh, must be before option -R.
         Exit codes: 0 success, 1 no recognizable options, 2 mistake after option, 3 wrong virtual machine number, 4 wrong remote host.