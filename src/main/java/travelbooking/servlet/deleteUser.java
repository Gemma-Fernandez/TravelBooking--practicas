package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import travelbooking.dao.Database;
import travelbooking.dao.UserDao;

import java.io.IOException;

import static travelbooking.dao.Database.jdbi;

@WebServlet("/deleteUser")

public class deleteUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // CONNECT DATABASE
            Database.connect();

            // GET ID
            int id =
                    Integer.parseInt(request.getParameter("id"));

            // DAO
            UserDao userDao =
                    jdbi.onDemand(UserDao.class);

            // DELETE
            userDao.delete(id);

            // REDIRECT
            response.sendRedirect("users.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "ERROR: " + e.getMessage()
            );
        }
    }
}