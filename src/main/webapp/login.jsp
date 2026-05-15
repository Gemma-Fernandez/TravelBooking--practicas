<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 15/5/26
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar Sesión - TravelBooking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<jsp:include page="includes/header.jsp" />

<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h3 class="card-title text-center mb-4">Iniciar Sesión</h3>

          <%-- Mensaje de error si fallan las credenciales --%>
          <% if (request.getParameter("error") != null) { %>
          <div class="alert alert-danger" role="alert">
            Email o contraseña incorrectos.
          </div>
          <% } %>

          <form action="login" method="POST">
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" id="email" name="email" required autofocus>
            </div>

            <div class="mb-3">
              <label for="password" class="form-label">Contraseña</label>
              <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Entrar</button>
          </form>

          <div class="text-center mt-3">
            <a href="createUser.jsp" class="text-decoration-none">¿No tienes cuenta? Regístrate</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>