FROM openjdk:11-jdk-alpine as build

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN ./mvnw dependency:go-offline -B

COPY src src

RUN ./mvnw package -DskipTests
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../* .jar)

FROM openjdk:11-jre-alpine

ARG DEPENDENCY=/app/target/dependency

COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /backend/lib
COPY --from=build ${DEPENDENCY}/META-INF /backend/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /backend

EXPOSE 8080

ENTRYPOINT ["java", "-cp", "backend:backend/lib/*", "me.test.apiserver.ApiServerApplication"]
