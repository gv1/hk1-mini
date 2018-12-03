set -x
case $* in                                                                                                             
        ubuntu)                                                                                                     
		# clean
		find . -maxdepth 1 -type l -delete
		ln -s  ubuntumate16.04/* .
		test -h sys && rm sys
		test -d sys || mkdir sys	
                ;;                                                              
	slackware)
		find . -maxdepth 1 -type l -delete
		ln -s slackware-14.2/* .
		;;
	tinycore)
		find . -maxdepth 1 -type l -delete
		ln -s tinycore-9.0.3v7/* .	
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
