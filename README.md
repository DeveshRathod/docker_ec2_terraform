# Shopease: eCommerce Application Deployment on AWS

Shopease is a full-stack eCommerce web application built with the **MERN** stack (MongoDB, Express.js, React, Node.js). This README provides an overview of the project’s features, development journey, and deployment process using Docker and AWS.

## Features

### User-facing Features:

- **Product Browsing**: View and search for products by categories and price.
- **Add to Cart**: Seamlessly add products to the shopping cart.
- **User Authentication**: JWT-based user login and signup.
- **Secure Payments**: Integrated with **Stripe** for handling payments.

### Admin Features:

- **Admin Dashboard**: Manage products, users, and orders.
- **Order Management**: Track and update the status of customer orders.

---

## Project Overview

### 1. Development - MERN Stack

The backend uses **Node.js** with **Express.js** for building RESTful APIs. The frontend is built with **React** for dynamic user interfaces, and **MongoDB** is used for database management. The key features of the application include:

- **JWT-based Authentication**: Securing routes and data with JSON Web Tokens.
- **Password Encryption**: Using **bcryptjs** to ensure the security of user credentials.
- **Stripe Integration**: Handling secure online payments.

### 2. Containerization with Docker

To ensure consistent development environments and simplify deployment:

- The entire app was containerized using **Docker**. Each service in the MERN stack (MongoDB, Express, React, Node) was encapsulated into Docker containers.
- **Docker Hub** was used to push the built Docker image for easy access during deployment.

#### Steps to Build and Push Docker Image (since I used Docker on macOS, I needed to use the platform flag to change OS to linux/amd64):

```bash
# Build Docker image for the app with amd64 platform
docker build --platform linux/amd64 -t <username>/<appname>:<tag> .

# Push Docker image to Docker Hub
docker push  <username>/<appname>:<tag>
```

### 3. Deployment on AWS

#### EC2 Instance

- The application was deployed on **Amazon EC2** instances, which host the app and handle incoming user traffic.
- The **Application Load Balancer (ALB)** was used to distribute traffic evenly across multiple instances.

#### S3 for Storage

- **Amazon S3** was used for file replication and storing state file to increase consistency

#### Multi-Region Deployment

- The app was deployed in two AWS regions: **Virginia** (US East) and **Mumbai** (AP South), to ensure reduced latency and higher availability for users from different geographies.

---

### 4. Infrastructure Management with Terraform

To streamline and automate the infrastructure setup, I used **Terraform** for managing AWS resources. This allowed for:

- **Provisioning**: Automatic creation of EC2 instances, load balancers, target groups, and other necessary components.
- **Infrastructure as Code**: Enabling easy replication of the infrastructure in different environments and regions.
- **Remote State Storage**: The Terraform state file was stored in an **S3** bucket, ensuring shared state across team members and better collaboration.

Terraform made scaling and updating the infrastructure seamless, ensuring that new resources were provisioned in a controlled and consistent manner.

---

### S3 Replication (Mumbai to Virginia)

To ensure high availability and redundancy, **S3 Cross-Region Replication (CRR)** was set up between the Mumbai (main) and Virginia (backup) regions. This ensures that all objects uploaded to the **Shopease S3 bucket** in the Mumbai region are automatically replicated to a backup S3 bucket in the Virginia region. The replication setup enhances data durability and allows for better disaster recovery.

The replication process was achieved through:

1. **S3 Bucket Creation**:

   - A primary bucket was created in **Mumbai** (ap-south-1).
   - A backup bucket was created in **Virginia** (us-east-1).

2. **Replication Configuration**:

   - **IAM Role** was set up to grant S3 the necessary permissions for replication.
   - A **Replication Rule** was created in the Mumbai bucket to replicate all objects to the Virginia bucket.

---

## Next Steps

### 1. Multi-Region DNS with AWS Route 53

- Plan to use **AWS Route 53** for improving the app's performance with global load balancing.

### 2. CI/CD Pipeline with Jenkins

- Automate the deployment process with **Jenkins** for continuous integration and delivery, ensuring faster updates.
