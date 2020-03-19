

while true; do
   echo "Testing if scm is out from the safe mode"
   kubectl logs ozone-scm-0 | grep "exiting safe mode"
   if [ $? == 0 ]; then
       break
   fi
   sleep 1
done


while true; do
   echo "Testing if OM has been started"
   kubectl logs ozone-om-0 | grep "HTTP server of ozoneManager listening"
   if [ $? == 0 ]; then
       break
   fi
   sleep 1
done


