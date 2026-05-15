<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 15/5/26
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="travelbooking.model.Trip" %>
<%@ page import="travelbooking.dao.TripDao" %>
<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%


  // Obtenemos todos los viajes de la base de datos
  List<Trip> trips = Database.jdbi.onDemand(TripDao.class).getAll();

  // Obtenemos el usuario actual de la sesión para mostrar/ocultar botones
  User currentUser = (User) session.getAttribute("user");
%>

<!doctype html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Viajes Disponibles - TravelBooking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="padding-top: 70px;">

<jsp:include page="includes/header.jsp" />

<div class="container mt-5">

  <h2 class="mb-4">Available Trips</h2>

  <table class="table table-bordered table-hover align-middle">

    <thead class="table-dark">
    <tr>
      <th>ID</th>
      <th>Title</th>
      <th>Destination</th>
      <th>Price</th>
      <th>Seats</th>
      <th>Departure date</th>
      <th>Status</th>
      <th>Actions</th>
    </tr>
    </thead>

    <tbody>

    <%
      if (trips != null && !trips.isEmpty()) {
        for(Trip t : trips) {
    %>

    <tr>
      <td><%= t.getId() %></td>
      <td><strong><%= t.getTitle() %></strong></td>
      <td><%= t.getCity() %>, <%= t.getCountry() %></td>
      <td><%= t.getPrice() %> €</td>
      <td><%= t.getSeats() %></td>
      <td><%= t.getDepartureDate() %></td>
      <td>
        <% if (t.isActive()) { %>
        <span class="badge bg-success">Activo</span>
        <% } else { %>
        <span class="badge bg-danger">Inactivo</span>
        <% } %>
      </td>

      <td>
        <a href="tripDetails.jsp?id=<%= t.getId() %>" class="btn btn-info btn-sm">
          View Details
        </a>

        <% if (currentUser != null && "ADMIN".equals(currentUser.getRole())) { %>

        <a href="editTrip.jsp?id=<%= t.getId() %>" class="btn btn-warning btn-sm">
          Edit
        </a>

        <a href="deleteTrip?id=<%= t.getId() %>" class="btn btn-danger btn-sm"
           onclick="return confirm('¿Seguro que quieres eliminar este viaje?')">
          Delete
        </a>

        <% } %>
      </td>

    </tr>

    <%
      }
    } else {
    %>
    <tr>
      <td colspan="8" class="text-center">No trips available at the moment.</td>
    </tr>
    <%
      }
    %>

    </tbody>

  </table>

</div>

<jsp:include page="includes/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>