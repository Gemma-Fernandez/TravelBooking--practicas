<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 15/5/26
  Time: 12:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.TripDao" %>
<%@ page import="travelbooking.model.Trip" %>
<%@ page import="travelbooking.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // BARRERA DE SEGURIDAD
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Buscamos los datos actuales
    try {
        Database.connect();
    } catch (ClassNotFoundException e) {
        throw new RuntimeException("Database driver not found", e);
    }
    int id = Integer.parseInt(request.getParameter("id"));
    Trip trip = Database.jdbi.onDemand(TripDao.class).getById(id);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Trip - TravelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light" style="padding-top: 70px;">

<jsp:include page="includes/header.jsp" />

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-warning text-dark">
                    <h4 class="mb-0">Edit Trip: <%= trip.getTitle() %></h4>
                </div>
                <div class="card-body">

                    <form action="updateTrip" method="POST">

                        <input type="hidden" name="id" value="<%= trip.getId() %>">
                        <input type="hidden" name="destinationId" value="<%= trip.getDestinationId() %>">

                        <div class="mb-3">
                            <label class="form-label">Trip Title</label>
                            <input type="text" class="form-control" name="title" value="<%= trip.getTitle() %>" required>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Country</label>
                                <input type="text" class="form-control" name="country" value="<%= trip.getCountry() %>" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">City</label>
                                <input type="text" class="form-control" name="city" value="<%= trip.getCity() %>" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" required><%= trip.getDescription() %></textarea>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Price (€)</label>
                                <input type="number" step="0.01" class="form-control" name="price" value="<%= trip.getPrice() %>" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Seats</label>
                                <input type="number" class="form-control" name="seats" value="<%= trip.getSeats() %>" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Departure Date</label>
                                <input type="date" class="form-control" name="departureDate" value="<%= trip.getDepartureDate() %>" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Image Name (e.g., paris.jpg)</label>
                            <input type="text" class="form-control" name="image" value="<%= trip.getImage() %>">
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" name="active" id="activeCheck" <%= trip.isActive() ? "checked" : "" %>>
                            <label class="form-check-label" for="activeCheck">
                                Active Trip (Visible to customers)
                            </label>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="trips.jsp" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-warning fw-bold">Save Changes</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
</body>
</html>
