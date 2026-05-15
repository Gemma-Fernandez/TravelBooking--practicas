<%@ page import="travelbooking.dao.Database" %>
<%@ page import="travelbooking.dao.UserDao" %>
<%@ page import="travelbooking.model.User" %>

<%@ page import="static travelbooking.dao.Database.jdbi" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%

  Database.connect();

  UserDao userDao = jdbi.onDemand(UserDao.class);

  int id = Integer.parseInt(request.getParameter("id"));

  User user = userDao.getById(id);

%>

<!doctype html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <title>Update User</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

  <h2 class="mb-4">
    Update User
  </h2>

  <form method="post"
        action="updateUser">

    <!-- ID -->
    <input type="hidden"
           name="id"
           value="<%= user.getId() %>">

    <!-- NAME -->
    <input type="text"
           name="name"
           class="form-control mb-3"
           value="<%= user.getName() %>"
           required>

    <!-- EMAIL -->
    <input type="email"
           name="email"
           class="form-control mb-3"
           value="<%= user.getEmail() %>"
           required>

    <!-- PASSWORD -->
    <input type="text"
           name="password"
           class="form-control mb-3"
           value="<%= user.getPassword() %>"
           required>

    <!-- ROLE -->
    <select name="role"
            class="form-control mb-3">

      <option value="USER"
              <%= user.getRole().equals("USER") ? "selected" : "" %>>

        USER

      </option>

      <option value="ADMIN"
              <%= user.getRole().equals("ADMIN") ? "selected" : "" %>>

        ADMIN

      </option>

    </select>

    <!-- ACTIVE -->
    <select name="active"
            class="form-control mb-3">

      <option value="true"
              <%= user.isActive() ? "selected" : "" %>>

        Active

      </option>

      <option value="false"
              <%= !user.isActive() ? "selected" : "" %>>

        Inactive

      </option>

    </select>

    <!-- REGISTER DATE -->
    <input type="date"
           name="registerDate"
           class="form-control mb-3"
           value="<%= user.getRegisterDate() %>">

    <!-- BALANCE -->
    <input type="number"
           step="0.01"
           name="balance"
           class="form-control mb-3"
           value="<%= user.getBalance() %>">

    <!-- BUTTON -->
    <button type="submit"
            class="btn btn-warning">

      Update User

    </button>

  </form>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>