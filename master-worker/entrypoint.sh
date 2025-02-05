#!/bin/bash

if [ "$1" = "master" ]; then
  export SPARK_MASTER_HOST=""
  export SPARK_MASTER_PORT=""
  
  # Get the IP address
  IP_ADDRESS=$(hostname -i)

  # Generate spark-defaults.conf
  cat <<EOF > $SPARK_HOME/conf/spark-defaults.conf
  spark.master client
  spark.driver.host $IP_ADDRESS
  spark.driver.port 44345
  spark.blockManager.port 40126 
  spark.executor.port 40127
  spark.ui.port=4040

EOF
  $SPARK_HOME/sbin/start-master.sh
  tail -f /dev/null
  
elif [ "$1" = "worker" ]; then
    export SPARK_MASTER_HOST=""
    export SPARK_MASTER_PORT=""
    export SPARK_MASTER_URL="spark://spark-master:7077"
    export SPARK_WORKER_PORT=8500
    # Start the Spark master
    $SPARK_HOME/sbin/start-worker.sh $SPARK_MASTER_URL
	tail -f /dev/null
elif [ "$1" = "run" ]; then
	tail -f /dev/null
else
    echo "Usage: $0 {master|worker}"
    exit 1
fi
