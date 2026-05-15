<%@ page import="java.util.List" %>

<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.TripDao" %>

<%@ page import="travelbooking.model.Trip" %>

<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%

  Database.connect();

  String search =
          request.getParameter("search");

  List<Trip> trips;

  TripDao tripDao =
          Database.jdbi
                  .onDemand(TripDao.class);

  if(search != null && !search.isEmpty()){

    trips = tripDao.searchTrips(search);

  } else {

    trips = tripDao.getAll();
  }

%>

<!doctype html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <title>
    Search Trips
  </title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

  <h2 class="mb-4">
    Search Trips
  </h2>

  <!-- SEARCH FORM -->
  <form method="get"
        action="searchTrips.jsp"
        class="mb-4">

    <div class="input-group">

      <input type="text"
             name="search"
             class="form-control"
             placeholder="Search by title, country or city">

      <button type="submit"
              class="btn btn-primary">

        Search

      </button>

    </div>

  </form>

  <!-- TRIPS -->
  <div class="row">

    <%

      for(Trip trip : trips){

    %>

    <div class="col-md-4 mb-4">

      <div class="card shadow-sm h-100">

        <img src="<%= request.getContextPath() %>/image/<%= trip.getImage() %>"
             class="card-img-top"
             style="height: 250px; object-fit: cover;">

        <div class="card-body">

          <h5 class="card-title">

            <%= trip.getTitle() %>

          </h5>

          <p class="card-text">

            <strong>Country:</strong>
            <%= trip.getCountry() %>

            <br>

            <strong>City:</strong>
            <%= trip.getCity() %>

            <br>

            <strong>Price:</strong>
            <%= trip.getPrice() %> €

            <br>

            <strong>Seats:</strong>
            <%= trip.getSeats() %>

            <br>

            <strong>Date:</strong>
            <%= trip.getDepartureDate() %>

          </p>

          <a href="tripDetails.jsp?id=<%= trip.getId() %>"
             class="btn btn-primary">

            View Trip

          </a>

        </div>

      </div>

    </div>

    <%

      }

    %>

  </div>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>
