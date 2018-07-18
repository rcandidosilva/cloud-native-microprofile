FROM openjdk:8

EXPOSE 9990
EXPOSE 8080

ADD target/*.jar /app.jar

RUN sh -c 'touch /app.jar'

USER root

RUN touch /audit.log && chmod 777 /audit.log

CMD java -Djava.net.preferIPv4Stack=true -jar /app.jar