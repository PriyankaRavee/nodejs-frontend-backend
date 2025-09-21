# Use Nginx to serve static HTML
FROM nginx:alpine

# Remove default Nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your HTML file to Nginx's web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80