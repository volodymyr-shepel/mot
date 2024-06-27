FROM openjdk:20-jdk
WORKDIR /app
COPY ../../product-service/target/product-service-0.0.1-SNAPSHOT.jar /app/app.jar
ENV ISSUER="MOT"\
    JWT_SECRET="h9MzEb9WR6kz5Lhz8McrHzBCn0Z7E9nsOdfUZ3C48mA\="\
    DATASOURCE_URL="jdbc:postgresql://postgres-product:5432/product"\
    DATASOURCE_USERNAME="admin"\
    DATASOURCE_PASSWORD="root"
CMD ["java", "-jar", "app.jar"]


