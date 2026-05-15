package travelbooking.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import travelbooking.dao.Database;
import travelbooking.dao.UserDao;
import travelbooking.model.User;

import java.io.IOException;
import java.time.LocalDate;

import static travelbooking.dao.Database.jdbi;

@WebServlet("/updateUser")

public class updateUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Database.connect();

            int id =
                    Integer.parseInt(request.getParameter("id"));

            String name =
                    request.getParameter("name");

            String email =
                    request.getParameter("email");

            String password =
                    request.getParameter("password");

            String role =
                    request.getParameter("role");

            boolean active =
                    Boolean.parseBoolean(request.getParameter("active"));

            LocalDate registerDate =
                    LocalDate.parse(request.getParameter("registerDate"));

            double balance =
                    Double.parseDouble(request.getParameter("balance"));

            User user = new User(
                    id,
                    name,
                    email,
                    password,
                    role,
                    active,
                    registerDate,
                    balance
            );

            UserDao userDao = jdbi.onDemand(UserDao.class);

            userDao.update(user);

            response.sendRedirect("users.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "ERROR: " + e.getMessage()
            );
        }
    }
}