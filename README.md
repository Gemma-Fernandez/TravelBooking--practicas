# ✈️ TravelBooking - Proyecto DAM

## 📌 Descripción

TravelBooking es una aplicación web desarrollada en Java que permite gestionar reservas de viajes turísticos.

La aplicación permite:

- Gestión de usuarios
- Gestión de viajes
- Reservas de viajes
- Control de plazas disponibles

El proyecto sigue una arquitectura basada en:

Modelo → DAO → Servlet → JSP

y utiliza MariaDB como base de datos relacional.

---

# 🎯 Objetivos del proyecto

- Aplicar modelado de bases de datos
- Implementar relaciones entre entidades
- Desarrollar operaciones CRUD completas
- Aplicar arquitectura DAO
- Gestionar usuarios y reservas
- Aplicar lógica de negocio real
- Crear una aplicación web funcional

---

# 🛠️ Tecnologías utilizadas

- Java
- JSP
- Servlets
- Maven
- MariaDB
- JDBI
- Bootstrap 5
- Apache Tomcat
- IntelliJ IDEA

---

# 🧩 Funcionalidades

## 👤 Usuarios

- Registro de usuarios
- Inicio de sesión
- Roles ADMIN / USER
- Gestión de saldo
- Activación/desactivación de usuarios

---

## ✈️ Trips

- Alta de viajes
- Edición de viajes
- Eliminación de viajes
- Gestión de plazas
- Fecha de salida
- Imagen del viaje
- Asociación a destinos

---

## 📅 Bookings

- Creación de reservas
- Cálculo automático del precio total
- Uso automático de la fecha del viaje
- Reserva asociada al usuario logueado
- Descuento automático de plazas
- Desactivación automática de viajes agotados

---

# 🗄️ Modelo Relacional

users [PK id, name, email, password, role, balance, active, register_date]

destinations [PK id, name, description, country, image, popular, active, created_at]

trips [PK id, title, description, country, city, price, seats, departure_date, active, image, FK destination_id]

bookings [PK id, people, total_price, booking_date, confirmed, FK user_id, FK trip_id]

payments [PK id, amount, payment_method, payment_date, completed, FK booking_id]

---

# 🔗 Relaciones

## 👤 Users ↔ Bookings

Users (1) ←→ (N) Bookings

- Un usuario puede realizar muchas reservas
- Cada reserva pertenece a un único usuario

---

## ✈️ Trips ↔ Bookings

Trips (1) ←→ (N) Bookings

- Un viaje puede tener muchas reservas
- Cada reserva pertenece a un único viaje

---

## 🌍 Destinations ↔ Trips

Destinations (1) ←→ (N) Trips

- Un destino puede tener muchos viajes
- Cada viaje pertenece a un único destino

---

## 💳 Bookings ↔ Payments

Bookings (1) ←→ (N) Payments

- Una reserva puede tener varios pagos
- Cada pago pertenece a una única reserva

---

# 🧠 Modelo Entidad Relación

## 📷 Diagrama ER

Añadir aquí la imagen del diagrama entidad-relación:

![Diagrama ER](images/diagrama-er.png)

---

# 📁 Estructura del proyecto

src
 ├── main
 │    ├── java
 │    │     ├── dao
 │    │     ├── model
 │    │     ├── servlet
 │    │
 │    ├── webapp
 │          ├── includes
 │          ├── images
 │          ├── *.jsp

---

# 🧱 Arquitectura utilizada

## 📌 Modelo

Clases Java que representan las entidades:

- User
- Trip
- Booking
- Destination
- Payment

---

## 📌 DAO

Acceso a base de datos usando JDBI.

Ejemplos:
- UserDao
- TripDao
- BookingDao

---

## 📌 Servlets

Controladores encargados de procesar las peticiones HTTP.

Ejemplos:
- addBooking
- addTrip
- deleteBooking
- updateTrip

---

## 📌 JSP

Interfaz visual de la aplicación.

Ejemplos:
- bookings.jsp
- trips.jsp
- createBooking.jsp
- bookingDetail.jsp

---

# ⚙️ Base de datos

Motor utilizado:

MariaDB

Conexión realizada mediante:

JDBI + JDBC

---

# 🚀 Funcionalidades destacadas

## ✔️ Cálculo automático de reservas

El sistema calcula automáticamente:

- precio total
- plazas restantes
- activación/desactivación de viajes

---

## ✔️ Gestión automática de plazas

Cuando un usuario realiza una reserva:

- se descuentan plazas
- si no quedan plazas:
  - el viaje se desactiva automáticamente

---

## ✔️ Gestión de roles

Existen dos roles:

ADMIN
USER

Los administradores pueden:
- editar
- eliminar
- gestionar entidades

---

# 🎨 Diseño

La interfaz utiliza:

Bootstrap 5

para crear una interfaz moderna y responsive.

---

# 📌 Autor

## 👨‍💻 Adrián Gabás Andreu

Proyecto desarrollado para:

DAM - Desarrollo de Aplicaciones Multiplataforma

---

# ✅ Estado del proyecto

Proyecto funcional y operativo

Incluye:
- CRUD completo
- Relaciones entre entidades
- Gestión de reservas
- Sistema de usuarios
- Persistencia en base de datos
- Arquitectura MVC simplificada con DAO + Servlets + JSP
