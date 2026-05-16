package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import travelbooking.dao.BookingDao;
import travelbooking.dao.Database;
import travelbooking.dao.UserDao;
import travelbooking.model.User;

import java.io.IOException;

import static travelbooking.dao.Database.jdbi;

@WebServlet("/deleteUser")

public class deleteUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 1. Verificamos que sea ADMIN
        if (currentUser != null && "ADMIN".equals(currentUser.getRole())) {
            int idToDelete = Integer.parseInt(request.getParameter("id"));

            // Guardamos de dónde viene para volver allí
            String referer = request.getHeader("Referer");
            String redirectUrl = (referer != null) ? referer : "users.jsp";

            try {
                Database.connect();
                BookingDao bookingDao = Database.jdbi.onDemand(BookingDao.class);

                // 2. Comprobamos si el usuario tiene reservas
                int bookingCount = bookingDao.countBookingsByUserId(idToDelete);

                if (bookingCount > 0) {
                    session.setAttribute("flashError", "Cannot delete user: this person has active bookings.");
                } else {
                    UserDao userDao = Database.jdbi.onDemand(UserDao.class);
                    userDao.deleteUser(idToDelete);
                    session.setAttribute("flashSuccess", "User deleted successfully.");
                }

                response.sendRedirect(redirectUrl);
                return;

            } catch (Exception e) {
                throw new ServletException(e);
            }
        }

        response.sendRedirect("index.jsp");
    }
}