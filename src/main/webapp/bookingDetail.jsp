<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.BookingDao" %>
<%@ page import="travelbooking.dao.UserDao" %>
<%@ page import="travelbooking.dao.TripDao" %>

<%@ page import="travelbooking.model.Booking" %>
<%@ page import="travelbooking.model.User" %>
<%@ page import="travelbooking.model.Trip" %>

<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%

    Database.connect();

    int id =
            Integer.parseInt(request.getParameter("id"));

    Booking booking =
            Database.jdbi
                    .onDemand(BookingDao.class)
                    .getById(id);

    User bookingUser =
            Database.jdbi
                    .onDemand(UserDao.class)
                    .getById(booking.getUserId());

    Trip trip =
            Database.jdbi
                    .onDemand(TripDao.class)
                    .getById(booking.getTripId());

%>

<!doctype html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        Booking Detail
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

    <h2 class="mb-4">
        Booking Detail
    </h2>

    <div class="card shadow-sm p-4">

        <p>
            <strong>User:</strong>
            <%= bookingUser.getName() %>
        </p>

        <p>
            <strong>Trip:</strong>
            <%= trip.getTitle() %>
        </p>

        <p>
            <strong>People:</strong>
            <%= booking.getPeople() %>
        </p>

        <p>
            <strong>Total Price:</strong>
            <%= booking.getTotalPrice() %> €
        </p>

        <p>
            <strong>Booking Date:</strong>
            <%= booking.getBookingDate() %>
        </p>

        <p>
            <strong>Confirmed:</strong>
            <%= booking.isConfirmed() ? "Yes" : "No" %>
        </p>

    </div>

    <a href="bookings.jsp"
       class="btn btn-secondary mt-3">

        Back

    </a>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>