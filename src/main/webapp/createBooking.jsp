<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

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

    <!-- USER ID -->
    <input type="number"
           name="userId"
           class="form-control mb-3"
           placeholder="User ID"
           required>

    <!-- TRIP ID -->
    <input type="number"
           name="tripId"
           class="form-control mb-3"
           placeholder="Trip ID"
           required>

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