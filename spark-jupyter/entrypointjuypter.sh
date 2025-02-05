#!/bin/bash
createuser=$1

if [ ! -d /spark/$createuser ]; then
mkdir -p /spark/$createuser
fi

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

filename="/spark/$createuser/requirementsforgupyter.txt"
if [ ! -f $filename ]; then
cp requirementsforgupyter.txt $filename
cp linearRegressionBostonHousing.ipynb /spark/$createuser/linearRegressionBostonHousing.ipynb 
cp spark-example.ipynb /spark/$createuser/spark-example.ipynb
cp boston_housing.csv /spark/$createuser/boston_housing.csv 
cp information.csv /spark/$createuser/information.csv

fi
pip install --no-cache-dir -r $filenamet

jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password='' --notebook-dir=/spark/$createuser
tail -f /dev/null
