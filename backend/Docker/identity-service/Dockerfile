FROM openjdk:20-jdk
VOLUME /tmp
ARG JAR_FILE=target/*.jar
COPY ../../identity-service/target/identity-service-0.0.1-SNAPSHOT.jar app.jar
#use locahost for now, not nginx(because it is submitted on gmail)
# need to use ip address
ENV BASE_URL="http://192.168.0.53:80"\
    ISSUER="MOT"\
    JWT_SECRET="h9MzEb9WR6kz5Lhz8McrHzBCn0Z7E9nsOdfUZ3C48mA\="\
    VERIFICATION_EMAIL_SUBJECT="Verify your email"\
    FORGET_PASSWORD_EMAIL_SUBJECT="Reset your password"\
    DATASOURCE_URL="jdbc:postgresql://postgres-identity:5432/identity"\
    DATASOURCE_USERNAME="admin"\
    DATASOURCE_PASSWORD="root"
ENTRYPOINT ["java","-jar","/app.jar"]