# 🛍️ ShopEase E-Commerce Platform

![React](https://img.shields.io/badge/Frontend-ReactJS-61DAFB?logo=react&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Backend-Spring%20Boot-6DB33F?logo=springboot&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-316192?logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Container-Docker-0db7ed?logo=docker&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions&logoColor=white)

---

## 📚 Table of Contents

1. [Overview](#-overview)
2. [Features (Modules)](#-features-modules)
3. [Project Structure](#-project-structure)
4. [ERD Design](#-erd-design)
5. [Technology Stack](#-technology-stack)
6. [Getting Started](#-getting-started)
7. [CI/CD Workflow](#-cicd-workflow)
8. [Future Enhancements](#-future-enhancements)
9. [Contributors](#-contributors)
10. [Screenshots](#-screenshots)

---

## 🧭 Overview

**ShopEase** is a full-featured **E-Commerce Platform** built using **React**, **Spring Boot**, and **PostgreSQL**.  
The system supports **user authentication**, **product management**, **order processing**, and **admin control panel**.  
All components are fully **Dockerized** and integrated with **GitHub Actions** for automated CI/CD workflows.

---

## 🚀 Features (Modules)

### 👤 **Authentication & User Management**
- User registration & login using JWT
- OAuth2 (Google Sign-In)
- Manage profile, addresses, and order history

### 🛒 **Product & Category**
- Product CRUD operations
- Category and category-type management
- Product images with Bunny.net CDN integration
- Filtering by price, size, color, and type

### 💳 **Cart & Checkout**
- Add/remove products from cart
- Real-time total calculation
- Mock checkout and payment process

### 📦 **Order Management**
- Manage order status (Pending, Confirmed, Shipped, Delivered)
- Order timeline tracking for users

### 🧑‍💼 **Admin Panel**
- Admin dashboard for managing products & categories
- Order overview and control
- Product statistics and management

---

## 🧱 Project Structure

```bash
KTMP_ShopEase/
├── UI/                           # Frontend (React)
│   ├── src/
│   │   ├── api/                  # API services (Axios)
│   │   ├── assets/               # Fonts, images, styles
│   │   ├── components/           # Reusable UI components
│   │   ├── pages/                # Application pages (Home, Cart, Admin, etc.)
│   │   ├── store/                # Redux store & slices
│   │   ├── utils/                # Helper utilities (JWT, cart utils, etc.)
│   │   └── index.js              # Entry point
│   ├── dockerfile
│   ├── nginx.conf
│   └── package.json
│
├── backend/                      # Backend (Spring Boot)
│   ├── controller/               # REST controllers (Product, Category, FileUpload)
│   ├── dto/                      # Data Transfer Objects
│   ├── entity/                   # JPA entities
│   ├── repository/               # JPA repositories
│   ├── service/                  # Business logic
│   ├── mapper/                   # Entity ↔ DTO mappers
│   ├── configuration/            # Swagger, security, app config
│   └── ShopeaseApplication.java  # Main entry point
│
├── database/                     # PostgreSQL setup
│   ├── dockerfile
│   ├── backup.sql
│   └── neondb.backup
│
├── docker-compose.yml            # Multi-container orchestration
├── .github/
│   └── workflows/
│       └── cicd.yml              # CI/CD pipeline (build → push → deploy)
├── shopEase.postman_collection.json
└── README.md

---

### 🧩 **ERD Design**

---

### 🧰 **Technology Stack**

| Layer | Technology | Description |
|-------|-------------|--------------|
| **Frontend** | ReactJS, Redux Toolkit, TailwindCSS | SPA architecture with modern state management |
| **Backend** | Spring Boot 3, JPA, Swagger | REST API, business logic, API documentation |
| **Database** | PostgreSQL 17 | Relational data storage |
| **Storage/CDN** | Bunny.net | Static asset hosting |
| **Containerization** | Docker, Docker Compose | Environment isolation and easy deployment |
| **CI/CD** | GitHub Actions | Automated build, test, and deploy pipeline |
| **Testing** | JUnit, Postman | Unit and integration testing |
