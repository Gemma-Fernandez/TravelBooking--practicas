package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import travelbooking.dao.BookingDao;
import travelbooking.dao.Database;
import travelbooking.dao.TripDao;
import travelbooking.model.User;

import java.io.IOException;

@WebServlet("/deleteTrip")
public class DeleteTripServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Comprobar que hay sesión y es ADMIN
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && "ADMIN".equals(user.getRole())) {
            int id = Integer.parseInt(request.getParameter("id"));

            // NUEVO: Guardar de dónde viene el usuario para devolverlo allí
            String referer = request.getHeader("Referer");
            // Si por algún motivo no hay origen, por defecto va a trips.jsp
            String redirectUrl = (referer != null) ? referer : "trips.jsp";

            // Conectar a la base de datos de forma segura
            try {
                Database.connect();
            } catch (ClassNotFoundException e) {
                throw new ServletException("Error al cargar la base de datos", e);
            }

            //Comprobar cuántas reservas tiene este viaje
            BookingDao bookingDao = Database.jdbi.onDemand(BookingDao.class);
            int bookingCount = bookingDao.countBookingsByTripId(id);

            // Tomar la decisión
            if (bookingCount > 0) {
                // Hay reservas: NO borramos y guardamos el error en sesión
                session.setAttribute("flashError", "Action denied! This trip cannot be deleted because it currently has active bookings.");
                response.sendRedirect(redirectUrl);
                return; // Cortamos la ejecución aquí
            } else {
                // No hay reservas: Borramos de forma segura
                TripDao tripDao = Database.jdbi.onDemand(TripDao.class);
                tripDao.deleteTrip(id);
                // Guardamos el éxito en sesión
                session.setAttribute("flashSuccess", "Success! The trip has been successfully deleted.");
                response.sendRedirect(redirectUrl);
                return;
            }
        }

        // Redirigir al menú principal si no es admin
        response.sendRedirect("index.jsp");
    }
}
