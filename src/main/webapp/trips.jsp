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


<%@ include file="includes/header.jsp" %>

<%
  // Nos aseguramos de conectar a la base de datos
  try {
    Database.connect();
  } catch (ClassNotFoundException e) {
    throw new ServletException("Database error", e);
  }

  TripDao tripDao = Database.jdbi.onDemand(TripDao.class);

  //Recogemos el parámetro de búsqueda si existe
  String search = request.getParameter("search");
  List<Trip> trips;

  // si hay búsqueda filtra, si no, trae todos
  if (search != null && !search.trim().isEmpty()) {
    trips = tripDao.searchTrips(search);
  } else {
    trips = tripDao.getAll();
  }
%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Trips - TravelBooking</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="padding-top: 70px;">

<div class="container mt-5">

  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Available Trips</h2>

    <%-- BUSCADOR INTEGRADO --%>
    <form action="trips.jsp" method="GET" class="d-flex w-50">
      <input type="text" name="search" class="form-control me-2"
             placeholder="Search by title, country or city..."
             value="<%= (search != null) ? search : "" %>">
      <button type="submit" class="btn btn-primary">Search</button>
      <% if (search != null) { %>
      <a href="trips.jsp" class="btn btn-outline-secondary ms-2">Clear</a>
      <% } %>
    </form>
  </div>


  <table class="table table-bordered table-hover align-middle shadow-sm">
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
        <span class="badge bg-success">Active</span>
        <% } else { %>
        <span class="badge bg-danger">Inactive</span>
        <% } %>
      </td>

      <td>
        <a href="tripDetails.jsp?id=<%= t.getId() %>" class="btn btn-info btn-sm">View</a>

        <% if (user != null && "ADMIN".equals(user.getRole())) { %>
        <a href="editTrip.jsp?id=<%= t.getId() %>" class="btn btn-warning btn-sm">Edit</a>
        <a href="deleteTrip?id=<%= t.getId() %>" class="btn btn-danger btn-sm"
           onclick="return confirm('Are you sure you want to delete this trip?')">Delete</a>
        <% } %>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="8" class="text-center">No trips found matching your criteria.</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>

</div>

<%@ include file="includes/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>