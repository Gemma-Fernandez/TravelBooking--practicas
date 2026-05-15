<%@ page import="java.util.List" %>
<%@ page import="travelbooking.model.Trip" %>
<%@ page import="travelbooking.dao.TripDao" %>
<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Database.connect();
    //Conectamos a la base de datos y sacamos los viajes
    List<Trip> trips = Database.jdbi.onDemand(TripDao.class).getAll();

    //Declaramos la variable 'user' para poder usarla
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>TravelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="padding-top: 70px;">

<jsp:include page="includes/header.jsp" />

<main>

    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light">TravelBooking</h1>
                <p class="lead text-body-secondary">
                    Discover amazing destinations around the world
                </p>
                <p>
                    <% if (user != null && "ADMIN".equals(user.getRole())) { %>
                    <a href="createTrip.jsp" class="btn btn-primary my-2">Add Trip</a>
                    <% } %>
                    <a href="index.jsp" class="btn btn-secondary my-2">View Trips</a>
                </p>
            </div>
        </div>
    </section>

    <div class="album py-5 bg-body-tertiary">
        <div class="container">
            <div class="row row-cols-1 row-cols-md-3 g-4">

                <%
                    if (trips != null) {
                        for (Trip t : trips) {
                %>

                <div class="col">
                    <div class="card h-100 shadow-sm">

                        <a href="tripDetails.jsp?id=<%= t.getId() %>">
                            <% if (t.getImage() != null && !t.getImage().isEmpty()) { %>
                            <img src="image/<%= t.getImage() %>" class="card-img-top" alt="<%= t.getTitle() %>" style="height: 200px; object-fit: cover;">
                            <% } else { %>
                            <div class="bg-secondary text-white d-flex align-items-center justify-content-center" style="height: 200px;">
                                No image
                            </div>
                            <% } %>
                        </a>

                        <div class="card-body">
                            <h5 class="card-title">
                                <a href="tripDetails.jsp?id=<%= t.getId() %>" class="text-decoration-none text-dark fw-bold">
                                    <%= t.getTitle() %>
                                </a>
                            </h5>
                            <p class="card-text text-muted mb-1">
                                Country: <%= t.getCountry() %> <br>
                                City: <%= t.getCity() %> <br>
                                Seats: <%= t.getSeats() %> <br>
                                Departure: <%= t.getDepartureDate() != null ? t.getDepartureDate() : "No date" %>
                            </p>
                            <p class="text-primary fw-bold fs-5 mt-2"><%= t.getPrice() %> €</p>
                        </div>

                        <div class="card-footer bg-transparent border-top-0 mb-2">

                            <a href="tripDetails.jsp?id=<%= t.getId() %>" class="btn btn-outline-primary w-100 mb-2">
                                See more details
                            </a>

                            <% if (user != null && "ADMIN".equals(user.getRole())) { %>
                            <div class="d-flex justify-content-between">
                                <a href="editTrip.jsp?id=<%= t.getId() %>" class="btn btn-sm btn-outline-warning w-50 me-1">Edit</a>
                                <a href="deleteTrip?id=<%= t.getId() %>" class="btn btn-sm btn-outline-danger w-50 ms-1"
                                   onclick="return confirm('Are you sure you want to delete this trip?')">Delete</a>
                            </div>
                            <% } %>

                        </div>

                    </div>
                </div>

                <%
                    }
                } else {
                %>
                <div class="col-12 text-center">
                    <p>No trips available</p>
                </div>
                <%
                    }
                %>

            </div>
        </div>
    </div>

</main>

<jsp:include page="includes/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>