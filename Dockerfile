# Use OpenJDK 11 runtime
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the host machine to the container
COPY target/my-web-app.jar /app/my-web-app.jar

# Expose port 8080 (or change as needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "/app/my-web-app.jar"]
