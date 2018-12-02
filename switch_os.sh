case $* in                                                                                                             
        ubuntu)                                                                                                     
		# clean
		find . -maxdepth 1 -type l -delete
		ln -s  ubuntumate16.04/* .
		rm sys
		mkdir sys	
                ;;                                                              
	slackware)
		find . -maxdepth 1 -type l -delete
		ln -s slackware-14.2/* .
		;;
        '')                                                                                                            
		echo "usage"
                echo "sh switch_os.sh slackware"                                                         
                echo "sh switch_os.sh ubuntu"                                                         
                ;;                                                                                                     
        *)                                                                                                             
		echo "unknown option $*"
                ;;                                                                                                     
esac                                            
