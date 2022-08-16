FROM maven:3.6.3-openjdk-8 
COPY . /dist 
RUN cd /dist && mvn clean install 
WORKDIR /dist/ 
CMD sleep 150 && mvn sonar:sonar 
-Dsonar.host.url=http://sonar-server:9000  
-Dsonar.language=java -Dsonar.login=admin 
-Dsonar.password=admin -Dsonar. projectKey=sonarbackend


FROM openjdk:8-alpine

# Required for starting application up.
RUN apk update && apk add /bin/sh

RUN mkdir -p /opt/app
ENV PROJECT_HOME /opt/app

COPY target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar

WORKDIR $PROJECT_HOME

CMD ["java" ,"-jar","./spring-boot-mongo.jar"]
