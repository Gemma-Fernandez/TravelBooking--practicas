package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import travelbooking.dao.Database;
import travelbooking.dao.TripDao;
import travelbooking.model.Trip;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/updateTrip")
public class UpdateTripServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Recogemos todos los parámetros que vienen del formulario
        int id = Integer.parseInt(request.getParameter("id"));
        int destinationId = Integer.parseInt(request.getParameter("destinationId"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        double price = Double.parseDouble(request.getParameter("price"));
        int seats = Integer.parseInt(request.getParameter("seats"));
        LocalDate departureDate = LocalDate.parse(request.getParameter("departureDate"));

        // Los checkbox en HTML envían "on" si están marcados, o null si no lo están
        boolean active = request.getParameter("active") != null;

        String image = request.getParameter("image");

        //Creamos el objeto Trip con los nuevos datos actualizados
        Trip updatedTrip = new Trip(id, title, description, country, city, price, seats, departureDate, active, image, destinationId);

        //Lo guardamos en la base de datos
        try {
            Database.connect();
        } catch (ClassNotFoundException e) {
            throw new ServletException("Error al cargar el driver de la base de datos", e);
        }
        TripDao tripDao = Database.jdbi.onDemand(TripDao.class);
        tripDao.updateTrip(updatedTrip);

        // 4. Redirigimos de vuelta a la página de detalles para ver cómo ha quedado
        response.sendRedirect("tripDetails.jsp?id=" + id);
    }
}
