# Stage 1: Build the app using Maven
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

# Copy your source code and Maven wrapper
COPY . .

# Build the application (skip tests for faster build)
RUN ./mvnw package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your app runs on
EXPOSE 8080

# Start the app
ENTRYPOINT ["java", "-jar", "app.jar"]
