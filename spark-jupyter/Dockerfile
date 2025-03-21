# Use a base image with Java installed
FROM openjdk:11-jre-slim

# Set environment variables
ENV SPARK_VERSION=3.5.3
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    python3-pip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install procps to get the ps command
RUN apt-get update && apt-get install -y procps && apt-get clean
RUN apt-get clean && apt-get update && apt-get install -y netcat
RUN apt-get update && apt-get install -y net-tools && rm -rf /var/lib/apt/lists/*

# Example command to check if ps works
RUN ps -e

RUN apt-get update && apt-get install dnsutils -y
RUN apt-get update && apt-get install -y telnet && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y iputils-ping && rm -rf /var/lib/apt/lists/*

# Download and install Spark
RUN curl -O https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get install -y texlive-xetex texlive-fonts-recommended texlive-plain-generic && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Default command (optional)
CMD ["xelatex", "--version"]


# Add Spark to PATH
ENV PATH=$PATH:${SPARK_HOME}/bin


# Expose ports
EXPOSE 7077 8080 4040 4041 8081 8082 7078 10000 30000 8888 8889

# Set working directory
WORKDIR ${SPARK_HOME} 

COPY requirements.txt .
COPY requirementsforgupyter.txt .
COPY entrypointjuypter.sh .
COPY linearRegressionBostonHousing.ipynb .
COPY spark-example.ipynb .
COPY boston_housing.csv .
COPY information.csv .

RUN pip install --no-cache-dir -r requirements.txt

#ARG createuser="createuser"
#ARG dirname=/spark/jupyter/users/$createuser
# Copy entrypoint script

RUN chmod +x entrypointjuypter.sh
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["./entrypointjuypter.sh test"]
#CMD ["sh", "-c", "/opt/spark/entrypointjuypter.sh test"]
#CMD ["sh", "-c", "tail -f /dev/null"]
