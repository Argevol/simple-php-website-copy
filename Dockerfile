# Use an official PHP runtime as a parent image
FROM php:7.4-cli

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run php -S on container startup
CMD ["php", "-S", "0.0.0.0:8080"]
