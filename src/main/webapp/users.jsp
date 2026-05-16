<%@ page import="java.util.List" %>

<%@ page import="travelbooking.model.User" %>
<%@ page import="travelbooking.dao.UserDao" %>
<%@ page import="travelbooking.dao.Database" %>

<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%

  Database.connect();

  List<User> users =
          Database.jdbi
                  .onDemand(UserDao.class)
                  .getAll();

%>

<!doctype html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <title>Users</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

  <h2 class="mb-4">
    Users
  </h2>

  <table class="table table-bordered table-hover">

    <thead class="table-dark">

    <tr>

      <th>ID</th>

      <th>Name</th>

      <th>Email</th>

      <th>Role</th>

      <th>Balance</th>

      <th>Active</th>

      <th>Register Date</th>

      <th>Actions</th>

    </tr>

    </thead>

    <tbody>

    <%

      for(User u : users){

    %>

    <tr>

      <td>
        <%= u.getId() %>
      </td>

      <td>
        <%= u.getName() %>
      </td>

      <td>
        <%= u.getEmail() %>
      </td>

      <td>
        <%= u.getRole() %>
      </td>

      <td>
        <%= u.getBalance() %> €
      </td>

      <td>
        <%= u.isActive() ? "Yes" : "No" %>
      </td>

      <td>
        <%= u.getRegisterDate() %>
      </td>

      <td>

        <!-- SOLO ADMIN -->
        <% if (user != null && "ADMIN".equals(user.getRole())) { %>

        <a href="updateUser.jsp?id=<%= u.getId() %>"
           class="btn btn-warning btn-sm">

          Edit

        </a>

        <a href="userDetail.jsp?id=<%= u.getId() %>"
           class="btn btn-info btn-sm">

          View

        </a>

        <a href="deleteUser?id=<%= u.getId() %>"
           class="btn btn-danger btn-sm"
           onclick="return confirm('Are you sure you want to delete this user?')">
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