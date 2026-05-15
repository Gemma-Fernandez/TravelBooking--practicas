<%@ page import="java.util.List" %>
<%@ page import="travelbooking.dao.BookingDao" %>
<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.UserDao" %>
<%@ page import="travelbooking.dao.TripDao" %>
<%@ page import="travelbooking.model.Booking" %>
<%@ page import="travelbooking.model.User" %>
<%@ page import="travelbooking.model.Trip" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ include file="includes/header.jsp" %>

<%


    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        Database.connect();
    } catch (ClassNotFoundException e) {
        throw new ServletException("Database error", e);
    }

    BookingDao bookingDao = Database.jdbi.onDemand(BookingDao.class);
    UserDao userDao = Database.jdbi.onDemand(UserDao.class);
    TripDao tripDao = Database.jdbi.onDemand(TripDao.class);

    List<Booking> bookings;


    if ("ADMIN".equals(user.getRole())) {
        bookings = bookingDao.getAll();
    } else {
        bookings = bookingDao.getByUserId(user.getId());
    }
%>


<!doctype html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>
        Bookings
    </title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->


<div class="container mt-5">

    <h2 class="mb-4">
        Bookings
    </h2>

    <% if (user != null) { %>

    <a href="createBooking.jsp"
       class="btn btn-success mb-3">

        Add Booking

    </a>

    <% } %>

    <table class="table table-bordered table-hover">

        <thead class="table-dark">

        <tr>

            <th>User</th>

            <th>Trip</th>

            <th>People</th>

            <th>Total Price</th>

            <th>Booking Date</th>

            <th>Confirmed</th>

            <th>Actions</th>

        </tr>

        </thead>

        <tbody>

        <%

            for(Booking booking : bookings){

                User bookingUser =
                        userDao.getById(booking.getUserId());

                Trip trip =
                        tripDao.getById(booking.getTripId());

        %>

        <tr>

            <td>
                <%= bookingUser.getName() %>
            </td>

            <td>
                <%= trip.getTitle() %>
            </td>

            <td>
                <%= booking.getPeople() %>
            </td>

            <td>
                <%= booking.getTotalPrice() %> €
            </td>

            <td>
                <%= booking.getBookingDate() %>
            </td>

            <td>
                <%= booking.isConfirmed() ? "Yes" : "No" %>
            </td>

            <td>

                <% if (user != null && "ADMIN".equals(user.getRole())) { %>

                <a href="updateBooking.jsp?id=<%= booking.getId() %>"
                   class="btn btn-warning btn-sm">

                    Edit

                </a>

                <a href="bookingDetail.jsp?id=<%= booking.getId() %>"
                   class="btn btn-info btn-sm">

                    View

                </a>

                <a href="deleteBooking?id=<%= booking.getId() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this booking?')">

                    Delete

                </a>

                <% } %>

            </td>

        </tr>

        <%

            }

        %>

        </tbody>

    </table>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>