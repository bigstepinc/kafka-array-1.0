FROM mcristinagrosu/bigstepinc_java_8

RUN apk update 
RUN apk add --no-cache openssh wget tar bash curl unzip alpine-sdk

# Apache Kafka
RUN cd /opt && \
    wget http://apache.mirror.anlx.net/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz 
    
RUN cd /opt && \
    tar xzvf /opt/kafka_2.11-0.10.1.0.tgz 
    
ENV KAFKA_HOME /opt/kafka_2.11-0.10.1.0 

RUN rm -rf /opt/kafka_2.11-0.10.1.0.tgz

ADD script.sh /opt/

ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod 777 /opt/entrypoint.sh

RUN apk del wget tar curl unzip

EXPOSE 2181 2888 3888

ENTRYPOINT ["/opt/entrypoint.sh"]
