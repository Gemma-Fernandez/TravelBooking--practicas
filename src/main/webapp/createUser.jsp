<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!doctype html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <title>Create User</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

</head>

<body style="padding-top: 70px;">

<!-- HEADER -->
<%@ include file="includes/header.jsp" %>

<div class="container mt-5">

  <h2 class="mb-4">
    Create User
  </h2>

  <!-- FORM -->
  <form method="post"
        action="addUser">

    <!-- NAME -->
    <input type="text"
           name="name"
           class="form-control mb-3"
           placeholder="Name"
           required>

    <!-- EMAIL -->
    <input type="email"
           name="email"
           class="form-control mb-3"
           placeholder="Email"
           required>

    <!-- PASSWORD -->
    <input type="password"
           name="password"
           class="form-control mb-3"
           placeholder="Password"
           required>

    <!-- ROLE -->
    <select name="role"
            class="form-control mb-3">

      <option value="USER">
        USER
      </option>

      <option value="ADMIN">
        ADMIN
      </option>

    </select>

    <!-- ACTIVE -->
    <select name="active"
            class="form-control mb-3">

      <option value="true">
        Active
      </option>

      <option value="false">
        Inactive
      </option>

    </select>

    <!-- REGISTER DATE -->
    <input type="date"
           name="registerDate"
           class="form-control mb-3">

    <!-- BALANCE -->
    <input type="number"
           step="0.01"
           name="balance"
           class="form-control mb-3"
           placeholder="Balance">

    <!-- BUTTON -->
    <button type="submit"
            class="btn btn-success">

      Save User

    </button>

  </form>

</div>

<!-- FOOTER -->
<%@ include file="includes/footer.jsp" %>

</body>
</html>
