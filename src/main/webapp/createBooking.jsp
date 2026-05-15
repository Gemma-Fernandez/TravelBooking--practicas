<%@ page import="java.util.List" %>

<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.TripDao" %>

<%@ page import="travelbooking.model.Trip" %>

<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%

  Database.connect();

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
    Create Booking
  </title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

  <h2 class="mb-4">
    Create Booking
  </h2>

  <!-- FORM -->
  <form method="post"
        action="addBooking">

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

    <!-- TRIP -->
    <label class="form-label">
      Select Trip
    </label>

    <select name="tripId"
            class="form-control mb-3"
            required>

      <%

        for(Trip trip : trips){

      %>

      <option value="<%= trip.getId() %>">

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
           placeholder="People"
           required>

    <!-- TOTAL PRICE -->
    <input type="number"
           step="0.01"
           name="totalPrice"
           class="form-control mb-3"
           placeholder="Total Price"
           required>

    <!-- BOOKING DATE -->
    <input type="date"
           name="bookingDate"
           class="form-control mb-3"
           required>

    <!-- CONFIRMED -->
    <select name="confirmed"
            class="form-control mb-3">

      <option value="true">
        Confirmed
      </option>

      <option value="false">
        Not Confirmed
      </option>

    </select>

    <!-- BUTTON -->
    <button type="submit"
            class="btn btn-success">

      Save Booking

    </button>

  </form>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>