# Use the official PHP image
FROM php:7.4-cli

# Set the working directory
WORKDIR /var/www/html

# Copy the application files into the container
COPY . .

# Expose the port your app runs on
EXPOSE 8080

# Command to run your application using PHP built-in server
CMD ["php", "-S", "0.0.0.0:8080"]
