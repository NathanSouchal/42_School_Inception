# 🏗️ Inception

Inception is a **system administration and Docker** project developed as part of the 42 School curriculum. It consists of building a secure, modular, and containerized web infrastructure using **Docker Compose**, focused on simplicity, isolation, and automation.

---

## 🎯 Project Goal

The goal of the project is to set up a fully functional and secure web server using containers, ensuring that each component of the stack runs in its own isolated Docker container.

---

## ⚙️ Tech Stack

- 🐳 Docker
- 🧱 Docker Compose
- 🐧 Debian
- 🌐 NGINX (reverse proxy + TLS with SSL certificates)
- 🐘 MariaDB (or MySQL)
- 🛠️ WordPress + phpMyAdmin
- 🔒 OpenSSL (self-signed certificate generation)
- ⚙️ Bash scripting

---

## 🚀 Services Overview

Each of these runs in a separate Docker container:

- **NGINX** — Serves HTTPS requests and handles TLS
- **WordPress** — Blog/CMS accessible through NGINX
- **MariaDB** — Database backend for WordPress
