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
    // Seguridad: Si no hay sesión, al login
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

    // Recogemos el parámetro de búsqueda
    String search = request.getParameter("search");
    List<Booking> bookings;

    //LÓGICA DE FILTRADO Y BÚSQUEDA
    if ("ADMIN".equals(user.getRole())) {
        if (search != null && !search.trim().isEmpty()) {
            bookings = bookingDao.searchBookings(search);
        } else {
            bookings = bookingDao.getAll();
        }
    } else {
        // El usuario normal solo ve sus reservas (sin buscador global)
        bookings = bookingDao.getByUserId(user.getId());
    }
%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bookings - TravelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="padding-top: 70px;">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Bookings</h2>

        <%--BUSCADOR(Solo visible ADMIN) --%>
        <% if ("ADMIN".equals(user.getRole())) { %>
        <form method="get" action="bookings.jsp" class="d-flex w-50">
            <input type="text" name="search" class="form-control me-2"
                   placeholder="Search by name or city..."
                   value="<%= (search != null) ? search : "" %>">
            <button type="submit" class="btn btn-primary">Search</button>
            <% if (search != null) { %>
            <a href="bookings.jsp" class="btn btn-outline-secondary ms-2">Clear</a>
            <% } %>
        </form>
        <% } %>
    </div>

    <%-- El usuario puede añadir reservas desde aquí --%>
    <% if (!"ADMIN".equals(user.getRole())) { %>
    <a href="createBooking.jsp" class="btn btn-success mb-3">Add New Booking</a>
    <% } %>

    <table class="table table-bordered table-hover shadow-sm">
        <thead class="table-dark">
        <tr>
            <% if ("ADMIN".equals(user.getRole())) { %> <th>User</th> <% } %>
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
                User bookingUser = userDao.getById(booking.getUserId());
                Trip trip = tripDao.getById(booking.getTripId());
        %>
        <tr>
            <% if ("ADMIN".equals(user.getRole())) { %>
            <td><%= bookingUser.getName() %></td>
            <% } %>
            <td><strong><%= (trip != null) ? trip.getTitle() : "Trip Deleted" %></strong></td>
            <td><%= booking.getPeople() %></td>
            <td><%= booking.getTotalPrice() %> €</td>
            <td><%= booking.getBookingDate() %></td>
            <td>
                    <span class="badge <%= booking.isConfirmed() ? "bg-success" : "bg-warning text-dark" %>">
                        <%= booking.isConfirmed() ? "Confirmed" : "Pending" %>
                    </span>
            </td>
            <td>
                <%-- Acciones comunes --%>
                <a href="bookingDetail.jsp?id=<%= booking.getId() %>" class="btn btn-info btn-sm">View</a>

                <%-- Acciones exclusivas de ADMIN --%>
                <% if ("ADMIN".equals(user.getRole())) { %>
                <a href="updateBooking.jsp?id=<%= booking.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                <a href="deleteBooking?id=<%= booking.getId() %>" class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure you want to delete this booking?')">Delete</a>
                <% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <% if (bookings.isEmpty()) { %>
    <div class="alert alert-info">No bookings found.</div>
    <% } %>

</div>

<%@ include file="includes/footer.jsp" %>

</body>
</html>