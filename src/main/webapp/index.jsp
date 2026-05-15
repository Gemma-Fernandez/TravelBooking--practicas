<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.TripDao" %>
<%@ page import="travelbooking.model.Trip" %>
<%@ page import="travelbooking.model.User" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="static travelbooking.dao.Database.jdbi" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!doctype html>
<html lang="en">

<head>

    <meta charset="utf-8" />

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <title>TravelBooking</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<main>

    <!-- HERO -->
    <section class="py-5 text-center container">

        <div class="row py-lg-5">

            <div class="col-lg-6 col-md-8 mx-auto">

                <h1 class="fw-light">
                    TravelBooking
                </h1>

                <p class="lead text-body-secondary">
                    Discover amazing destinations around the world
                </p>

                <p>

                    <!-- SOLO ADMIN -->
                    <% if (user != null && "ADMIN".equals(user.getRole())) { %>

                    <a href="createTrip.jsp"
                       class="btn btn-primary my-2">

                        Add Trip

                    </a>

                    <% } %>

                    <a href="index.jsp"
                       class="btn btn-secondary my-2">

                        View Trips

                    </a>

                </p>

            </div>

        </div>

    </section>

    <!-- LISTADO -->
    <div class="album py-5 bg-body-tertiary">

        <div class="container">

            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

                <%

                    List<Trip> trips = new ArrayList<>();

                    try {

                        Database.connect();

                        TripDao tripDao = jdbi.onDemand(TripDao.class);

                        trips.addAll(tripDao.getAll());

                    } catch (Exception e) {

                %>

                <p style="color:red;">
                    ERROR: <%= e.getMessage() %>
                </p>

                <%
                    }
                %>

                <%

                    for (Trip trip : trips) {

                %>

                <div class="col">

                    <a href="tripDetail.jsp?id=<%= trip.getId() %>"
                       style="text-decoration:none; color:inherit;">

                        <div class="card shadow-sm">

                            <img src="<%= request.getContextPath() %>/images/<%= trip.getImage() %>"
                                 class="card-img-top"
                                 style="height:225px; object-fit:cover;">

                            <div class="card-body">

                                <p class="card-text">

                                    <strong>
                                        <%= trip.getTitle() %>
                                    </strong>

                                    <br>

                                    Country:
                                    <%= trip.getCountry() %>

                                    <br>

                                    City:
                                    <%= trip.getCity() %>

                                    <br>

                                    Price:
                                    <%= trip.getPrice() %> €

                                    <br>

                                    Seats:
                                    <%= trip.getSeats() %>

                                </p>

                                <div class="d-flex justify-content-between align-items-center">

                                    <!-- SOLO ADMIN -->
                                    <% if (user != null && "ADMIN".equals(user.getRole())) { %>

                                    <div class="btn-group">

                                        <a href="editTrip.jsp?id=<%= trip.getId() %>"
                                           class="btn btn-sm btn-outline-warning"
                                           onclick="event.stopPropagation();">

                                            Edit

                                        </a>

                                        <a href="deleteTrip?id=<%= trip.getId() %>"
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="event.stopPropagation();
                                           return confirm('Are you sure you want to delete this trip?')">

                                            Delete

                                        </a>

                                    </div>

                                    <% } %>

                                    <small class="text-body-secondary">

                                        ID:
                                        <%= trip.getId() %>

                                    </small>

                                </div>

                                <small>

                                    Departure Date:

                                    <%= trip.getDepartureDate() != null
                                            ? trip.getDepartureDate()
                                            : "No date" %>

                                </small>

                            </div>

                        </div>

                    </a>

                </div>

                <%
                    }
                %>

            </div>

        </div>

    </div>

</main>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>