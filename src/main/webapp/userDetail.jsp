<%@ page import="travelbooking.dao.*" %>
<%@ page import="travelbooking.model.User" %>

<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%

  Database.connect();

  int id =
          Integer.parseInt(request.getParameter("id"));

  User selectedUser =
          Database.jdbi
                  .onDemand(UserDao.class)
                  .getById(id);

%>

<!doctype html>
<html lang="en">

<head>

  <title>
    User Detail
  </title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

  <h2 class="mb-4">
    User Detail
  </h2>

  <div class="card shadow-sm p-4">

    <p>
      <strong>ID:</strong>
      <%= selectedUser.getId() %>
    </p>

    <p>
      <strong>Name:</strong>
      <%= selectedUser.getName() %>
    </p>

    <p>
      <strong>Email:</strong>
      <%= selectedUser.getEmail() %>
    </p>

    <p>
      <strong>Role:</strong>
      <%= selectedUser.getRole() %>
    </p>

    <p>
      <strong>Balance:</strong>
      <%= selectedUser.getBalance() %> €
    </p>

    <p>
      <strong>Active:</strong>
      <%= selectedUser.isActive() ? "Yes" : "No" %>
    </p>

    <p>
      <strong>Register Date:</strong>
      <%= selectedUser.getRegisterDate() %>
    </p>

  </div>

  <a href="users.jsp"
     class="btn btn-secondary mt-3">

    Back

  </a>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>