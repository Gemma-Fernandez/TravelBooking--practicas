package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import travelbooking.dao.BookingDao;
import travelbooking.dao.Database;
import travelbooking.dao.TripDao;

import travelbooking.model.Booking;
import travelbooking.model.Trip;

import java.io.IOException;
import java.time.LocalDate;

import static travelbooking.dao.Database.jdbi;

@WebServlet("/addBooking")

public class addBooking extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Database.connect();

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
                    0,
                    userId,
                    tripId,
                    people,
                    totalPrice,
                    bookingDate,
                    confirmed
            );

            BookingDao bookingDao =
                    jdbi.onDemand(BookingDao.class);

            TripDao tripDao =
                    jdbi.onDemand(TripDao.class);

            // SAVE BOOKING
            bookingDao.add(booking);

            // GET TRIP
            Trip trip =
                    tripDao.getById(tripId);

            // CALCULATE NEW SEATS
            int newSeats =
                    trip.getSeats() - people;

            // ACTIVE?
            boolean active =
                    newSeats > 0;

            // UPDATE TRIP
            tripDao.updateSeatsAndActive(
                    tripId,
                    newSeats,
                    active
            );

            response.sendRedirect("bookings.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "ERROR: " + e.getMessage()
            );
        }
    }
}