# Virtualized Environment Using Docker - TASK2
This repository contains the instructions for setting up a virtualized environment using Docker to host a web application on a Google Cloud VM. Nginx is used as the web server for serving the application.

# Table of Contents
- [Overview](https://github.com/kawin048/CLOUD_TASK2/blob/main/README.md#overview)
- [Prerequisites](https://github.com/kawin048/CLOUD_TASK2/blob/main/README.md#prerequisites)
- [Installation](https://github.com/kawin048/CLOUD_TASK2/blob/main/README.md#installation)
- [Creation of Virtual Machine](https://github.com/kawin048/CLOUD_TASK2/blob/main/README.md#creation-of-virtual-machine)
- [Accessing the Application](https://github.com/kawin048/CLOUD_TASK2/blob/main/README.md#accessing-the-application)
- [Result](https://github.com/kawin048/CLOUD_TASK2/blob/main/README.md#result)

# Overview 
- Clone the source code repository from GitHub.
- Create a Dockerfile to use Nginx as a web server to serve static files.
- Configure Docker Authentication
- Build and Push Docker Image
- Set Up Google Cloud VM
- Create Firewall Rule that Allows traffic on port 8000 to access the application
- Deploy Docker Container on VM
- Access the Application

# Prerequisites
- Google Cloud account and project setup
- Ensure you have a neceesary permissions for services
- Enable required Api's

# Installation

1. Clone the github repo
```bash
https://github.com/kawin048/CLOUD_TASK2.git
```
2. Create the Dockerfile

```bash
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

```
3. Configure Docker
   
```bash
   gcloud auth configure-docker
```
 
4. Build and Push Docker Image

```bash

docker build -t gcr.io/YOUR_PROJECT_ID/YOUR_WEB_APP .
docker tag YOUR_WEB_APP gcr.io/YOUR_PROJECT_ID/YOUR_WEB_APP

```
5. Push Docker Image to Google Container Registry
```bash
   docker push gcr.io/YOUR_PROJECT_ID/YOUR_WEB_APP
```
# Creation of Virtual Machine

1. Enable Compute Engine Api

```bash
   gcloud services enable compute.googleapis.com
```
 
2. VM Setup and Installing Docker
   
```bash
gcloud compute instances create $VM_NAME \
  --zone=$ZONE \
  --machine-type=e2-micro \
  --subnet=$SUBNET_NAME \
  --tags=http-server \
  --metadata=startup-script='#! /bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
```
3. Create a firewall wall rule:
As i already a vm instance and vpc in my previous task so i am using the same vm and vpc and setting up new firewall rule to allow specific port 8000 to server my web application.

```bash
gcloud compute firewall-rules create $FIREWALL_RULE_NAME \
  --network=$NETWORK_NAME \
  --allow=tcp:8000 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=http-server
```
4. SSH into Vm:
```bash
gcloud compute ssh YOUR_VM_NAME
```
5. Pull and Run Docker Container:
```bash
docker pull gcr.io/YOUR_PROJECT_ID/YOUR_WEB_APP
docker run -d -p 8000:80 gcr.io/YOUR_PROJECT_ID/YOUR_WEB_APP
```
6. To keep the docker ruuning in the background
```bash
   docker run -d -p 8080:80 --restart unless-stopped gcr.io/YOUR_PROJECT_ID/YOUR_WEB_APP
```
7. Verify Deployment
```bash
docker ps
```
# Accessing the Application
- Open a browser and navigate to the external IP of the VM instance to access the application.
- Example: http://[VM_EXTERNAL_IP]:8000

# Result 
After following all steps,I successfully built the web application that is  now be accessible through the specified IP and port, serving the application content via the Nginx server within a Docker container hosted on the Google Cloud VM instance.
- To access the application : [Click Here](http://34.172.35.91:8000)
  

  



 




