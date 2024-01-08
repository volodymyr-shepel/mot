FROM openjdk:20-jdk
COPY ../../notification-service/target/notification-service-0.0.1-SNAPSHOT.jar app.jar
ENV EMAIL_FROM="shop.mot.pl@gmail.com" \
    EMAIL_FROM_NAME="MOT" \
    MAIL_PASSWORD="sevu rpjy niek qkhk" \
    MAIL_USERNAME="shop.mot.pl@gmail.com"
ENTRYPOINT ["java", "-jar", "/app.jar"]
