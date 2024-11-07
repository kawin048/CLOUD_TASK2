# Use the official NGINX image as the base image
FROM nginx:latest

# Copy HTML and CSS files to the default NGINX html directory
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css
COPY responsive.css /usr/share/nginx/html/responsive.css
COPY animations.css /usr/share/nginx/html/animations.css

# Copy the images folder (including the 3 tree images) to the NGINX html directory
COPY images /usr/share/nginx/html/images

# Expose port 80 to make the service accessible
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
