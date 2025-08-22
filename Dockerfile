# --- Stage 1: Build React frontend ---
FROM node:20-alpine AS frontend-builder

WORKDIR /client

# Install deps only when package.json changes
COPY client/package*.json ./
RUN npm install --legacy-peer-deps

# Copy rest of client code and build
COPY client/ ./

# Clean any existing build and create fresh build
RUN rm -rf dist/ build/ && \
    npm run build && \
    echo "✅ Frontend build completed. Contents of dist:" && \
    ls -la dist/ && \
    echo "📦 Total frontend files:" && \
    find dist/ -type f | wc -l


# --- Stage 2: Build Spring Boot with frontend ---
FROM maven:3.9.6-eclipse-temurin-21 AS backend-builder

WORKDIR /app

# Cache Maven dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy backend source FIRST
COPY src ./src

# COMPLETELY REMOVE all existing static files and directories
RUN rm -rf ./src/main/resources/static
RUN mkdir -p ./src/main/resources/static

# Copy frontend build into Spring Boot static folder
COPY --from=frontend-builder /client/dist/ ./src/main/resources/static/

# Verify the copy worked and show what's in static folder
RUN echo "✅ Contents of static folder after frontend copy:" && \
    ls -la ./src/main/resources/static/ && \
    echo "📦 Total files in static:" && \
    find ./src/main/resources/static -type f | wc -l && \
    echo "📁 File list:" && \
    find ./src/main/resources/static -type f | head -10

# Package Spring Boot JAR with new static files
RUN mvn clean package -DskipTests -B


# --- Stage 3: Runtime (minimal) ---
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Copy only final JAR from build stage
COPY --from=backend-builder /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run Spring Boot JAR
ENTRYPOINT ["java", "-jar", "app.jar"]