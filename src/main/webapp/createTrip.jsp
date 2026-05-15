<%--
  Created by IntelliJ IDEA.
  User: gemmafernandez
  Date: 15/5/26
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="travelbooking.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // solo admin puede acceder
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Trip - TravelBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light" style="padding-top: 70px;">

<jsp:include page="includes/header.jsp" />

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Add New Trip</h4>
                </div>
                <div class="card-body">

                    <form action="addTrip" method="POST" enctype="multipart/form-data">

                        <div class="mb-3">
                            <label class="form-label">Trip Title</label>
                            <input type="text" class="form-control" name="title" placeholder="e.g. Rome Getaway" required>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Country</label>
                                <input type="text" class="form-control" name="country" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">City</label>
                                <input type="text" class="form-control" name="city" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" required></textarea>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label">Price (€)</label>
                                <input type="number" step="0.01" class="form-control" name="price" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Seats</label>
                                <input type="number" class="form-control" name="seats" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Departure Date</label>
                                <input type="date" class="form-control" name="departureDate" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Image Name (e.g., rome.jpg)</label>
                            <div class="mb-3">
                                <label class="form-label">Upload Image</label>
                                <input type="file" class="form-control" name="imageFile" accept="image/*">

                                <input type="hidden" name="destinationId" value="1">
                            </div>

                            <input type="hidden" name="destinationId" value="1">
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" name="active" id="activeCheck" checked>
                            <label class="form-check-label" for="activeCheck">
                                Active Trip (Visible to customers immediately)
                            </label>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="index.jsp" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary fw-bold">Create Trip</button>
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
