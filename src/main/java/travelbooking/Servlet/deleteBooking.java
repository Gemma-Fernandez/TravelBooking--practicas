package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import travelbooking.dao.BookingDao;
import travelbooking.dao.Database;

import java.io.IOException;

import static travelbooking.dao.Database.jdbi;

@WebServlet("/deleteBooking")

public class deleteBooking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Database.connect();

            int id =
                    Integer.parseInt(request.getParameter("id"));

            BookingDao bookingDao =
                    jdbi.onDemand(BookingDao.class);

            bookingDao.delete(id);

            response.sendRedirect("bookings.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "ERROR: " + e.getMessage()
            );
        }
    }
}