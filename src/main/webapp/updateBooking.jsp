<%@ page import="java.util.List" %>

<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.BookingDao" %>
<%@ page import="travelbooking.dao.TripDao" %>

<%@ page import="travelbooking.model.Booking" %>
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

  List<Trip> trips =
          Database.jdbi
                  .onDemand(TripDao.class)
                  .getAll();

%>

<!doctype html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <title>
    Update Booking
  </title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

  <h2 class="mb-4">
    Update Booking
  </h2>

  <form method="post"
        action="updateBooking">

    <!-- BOOKING ID -->
    <input type="hidden"
           name="id"
           value="<%= booking.getId() %>">

    <!-- USER -->
    <label class="form-label">
      User
    </label>

    <input type="text"
           class="form-control mb-3"
           value="<%= user.getName() %>"
           disabled>

    <!-- HIDDEN USER ID -->
    <input type="hidden"
           name="userId"
           value="<%= user.getId() %>">

    <!-- TRIPS -->
    <label class="form-label">
      Select Trip
    </label>

    <select name="tripId"
            class="form-control mb-3"
            required>

      <%

        for(Trip trip : trips){

      %>

      <option value="<%= trip.getId() %>"
              <%= booking.getTripId() == trip.getId() ? "selected" : "" %>>

        <%= trip.getTitle() %>

      </option>

      <%

        }

      %>

    </select>

    <!-- PEOPLE -->
    <input type="number"
           name="people"
           class="form-control mb-3"
           value="<%= booking.getPeople() %>"
           required>

    <!-- TOTAL PRICE -->
    <input type="number"
           step="0.01"
           name="totalPrice"
           class="form-control mb-3"
           value="<%= booking.getTotalPrice() %>"
           required>

    <!-- BOOKING DATE -->
    <input type="date"
           name="bookingDate"
           class="form-control mb-3"
           value="<%= booking.getBookingDate() %>"
           required>

    <!-- CONFIRMED -->
    <select name="confirmed"
            class="form-control mb-3">

      <option value="true"
              <%= booking.isConfirmed() ? "selected" : "" %>>

        Confirmed

      </option>

      <option value="false"
              <%= !booking.isConfirmed() ? "selected" : "" %>>

        Not Confirmed

      </option>

    </select>

    <!-- BUTTON -->
    <button type="submit"
            class="btn btn-warning">

      Update Booking

    </button>

  </form>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>