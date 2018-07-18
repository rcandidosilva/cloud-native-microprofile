FROM openjdk:8

ARG SPEAKER_SERVICE
ENV SPEAKER_SERVICE ${SPEAKER_SERVICE:-http://172.17.0.1:8080/speakers}

EXPOSE 9991
EXPOSE 8081

ADD target/*.jar /app.jar

RUN sh -c 'touch /app.jar'

USER root

RUN touch /audit.log && chmod 777 /audit.log

CMD java -Djava.net.preferIPv4Stack=true -jar /app.jar