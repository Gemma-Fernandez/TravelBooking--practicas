<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 15/5/26
  Time: 12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.TripDao" %>
<%@ page import="travelbooking.model.Trip" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%


    // Recogemos el ID de la URL
    int id = Integer.parseInt(request.getParameter("id"));

    // Buscamos el viaje en la base de datos
    Trip selectedTrip = Database.jdbi.onDemand(TripDao.class).getById(id);
%>

<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Trip Details - TravelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="padding-top: 70px;">

<jsp:include page="includes/header.jsp" />

<div class="container mt-5">

    <h2 class="mb-4">Trip Details</h2>

    <% if (selectedTrip != null) { %>
    <div class="card shadow-sm p-4">

        <div class="row">
            <%--Columna datos del viaje --%>
            <div class="col-md-8">
                <h3 class="text-primary"><%= selectedTrip.getTitle() %></h3>
                <hr>
                <p><strong>Trip ID:</strong> <%= selectedTrip.getId() %></p>
                <p><strong>Destination:</strong> <%= selectedTrip.getCity() %>, <%= selectedTrip.getCountry() %></p>
                <p><strong>Description:</strong> <%= selectedTrip.getDescription() %></p>
                <p><strong>Price:</strong> <%= selectedTrip.getPrice() %> €</p>
                <p><strong>Available Seats:</strong> <%= selectedTrip.getSeats() %></p>
                <p><strong>Departure date: </strong> <%= selectedTrip.getDepartureDate() %></p>
                <p><strong>Status:</strong>
                    <% if (selectedTrip.isActive()) { %>
                    <span class="badge bg-success">Active</span>
                    <% } else { %>
                    <span class="badge bg-danger">Inactive</span>
                    <% } %>
                </p>
            </div>


            <div class="col-md-4 text-center">
                <% if (selectedTrip.getImage() != null && !selectedTrip.getImage().isEmpty()) { %>
                <img src="images/<%= selectedTrip.getImage() %>" alt="<%= selectedTrip.getTitle() %>" class="img-fluid rounded shadow-sm" style="max-height: 250px;">
                <% } else { %>
                <div class="p-5 bg-light text-muted rounded shadow-sm">No image available</div>
                <% } %>
            </div>
        </div>

    </div>
    <% } else { %>
    <div class="alert alert-warning">The requested trip was not found.</div>
    <% } %>

    <%
        //Preguntamos al navegador de qué página viene el usuario
        String paginaAnterior = request.getHeader("Referer");

        //Asumimos que vuelve a la página principal
        String rutaVolver = "index.jsp";

        //Si la página de la que viene contiene "trips.jsp" cambiamos la ruta
        if (paginaAnterior != null && paginaAnterior.contains("trips.jsp")) {
            rutaVolver = "trips.jsp";
        }
    %>

    <a href="<%= rutaVolver %>" class="btn btn-secondary mt-4">Go back</a>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
