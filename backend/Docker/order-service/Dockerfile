FROM openjdk:20-jdk
WORKDIR /app
COPY ../../order-service/target/order-service-0.0.1-SNAPSHOT.jar /app/app.jar
ENV BASE_URL="http://localhost:80"\
    NOTIFICATION_URL="notification-service"\
    NOTIFICATION_PORT="8082"\
    NGINX_URL="nginx"\
    ISSUER="MOT"\
    JWT_SECRET="h9MzEb9WR6kz5Lhz8McrHzBCn0Z7E9nsOdfUZ3C48mA\="\
    DATASOURCE_URL="jdbc:postgresql://postgres-order:5432/order"\
    DATASOURCE_USERNAME="admin"\
    DATASOURCE_PASSWORD="root"
CMD ["java", "-jar", "app.jar"]


