<%@ page import="travelbooking.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header data-bs-theme="dark">

    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">

        <div class="container-fluid">

            <a class="navbar-brand"
               href="index.jsp">

                TravelBooking

            </a>

            <button class="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">

                <span class="navbar-toggler-icon"></span>

            </button>

            <div class="collapse navbar-collapse"
                 id="navbarCollapse">

                <%

                    User user = (User) session.getAttribute("user");

                %>

                <!-- MENU -->
                <ul class="navbar-nav me-auto">

                    <!-- HOME -->
                    <li class="nav-item">

                        <a class="nav-link active"
                           href="index.jsp">

                            Home

                        </a>

                    </li>

                    <!-- USER Y ADMIN -->
                    <% if (user != null) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="index.jsp">

                            Trips

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="searchTrips.jsp">

                            Search Trips

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="bookings.jsp">

                            Bookings

                        </a>

                    </li>

                    <% } %>

                    <!-- SOLO ADMIN -->
                    <% if (user != null && "ADMIN".equals(user.getRole())) { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="createTrip.jsp">

                            Add Trip

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="trips.jsp">

                            Manage Trips

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="users.jsp">

                            Users

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="createUser.jsp">

                            Add User

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="searchUsers.jsp">

                            Search User

                        </a>

                    </li>



                    <% } %>

                </ul>

                <!-- LOGIN -->
                <ul class="navbar-nav ms-auto">

                    <% if (user != null) { %>

                    <li class="nav-item">

                        <span class="nav-link">

                            👤 <%= user.getName() %>
                            (<%= user.getRole() %>)

                        </span>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="logout">

                            Logout

                        </a>

                    </li>

                    <% } else { %>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="createUser.jsp">

                            Register

                        </a>

                    </li>

                    <li class="nav-item">

                        <a class="nav-link"
                           href="login.jsp">

                            Login

                        </a>

                    </li>

                    <% } %>

                </ul>

            </div>

        </div>

    </nav>

</header>

<div class="container" style="padding-top: 80px;">
<%
    // Recuperamos los mensajes de la sesión
    String flashError = (String) session.getAttribute("flashError");
    String flashSuccess = (String) session.getAttribute("flashSuccess");

    // Si hay un error, lo mostramos en rojo y lo borramos de la sesión
    if (flashError != null) {
%>
<div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
    <%= flashError %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
        session.removeAttribute("flashError");
    }

    // Si hay un éxito, lo mostramos en verde y lo borramos de la sesión
    if (flashSuccess != null) {
%>
<div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
    <%= flashSuccess %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
        session.removeAttribute("flashSuccess");
    }
%>
</div>