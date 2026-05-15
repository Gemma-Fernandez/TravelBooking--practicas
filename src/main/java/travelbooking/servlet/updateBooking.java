package travelbooking.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import travelbooking.dao.BookingDao;
import travelbooking.dao.Database;

import travelbooking.model.Booking;

import java.io.IOException;
import java.time.LocalDate;

import static travelbooking.dao.Database.jdbi;

@WebServlet("/updateBooking")

public class updateBooking extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        try {

            Database.connect();

            int id =
                    Integer.parseInt(request.getParameter("id"));

            int userId =
                    Integer.parseInt(request.getParameter("userId"));

            int tripId =
                    Integer.parseInt(request.getParameter("tripId"));

            int people =
                    Integer.parseInt(request.getParameter("people"));

            double totalPrice =
                    Double.parseDouble(request.getParameter("totalPrice"));

            LocalDate bookingDate =
                    LocalDate.parse(request.getParameter("bookingDate"));

            boolean confirmed =
                    Boolean.parseBoolean(request.getParameter("confirmed"));

            Booking booking = new Booking(
                    id,
                    userId,
                    tripId,
                    people,
                    totalPrice,
                    bookingDate,
                    confirmed
            );

            BookingDao bookingDao =
                    jdbi.onDemand(BookingDao.class);

            bookingDao.update(booking);

            response.sendRedirect("bookings.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "ERROR: " + e.getMessage()
            );
        }
    }
}