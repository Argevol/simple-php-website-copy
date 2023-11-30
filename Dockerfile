# Use the official Nginx image
FROM nginx:latest

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy your Nginx configuration file
COPY nginx/default.conf /etc/nginx/conf.d/

# Copy your application files
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
