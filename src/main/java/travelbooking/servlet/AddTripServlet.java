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

@WebServlet("/addTrip")
public class AddTripServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Recogemos los parámetros del formulario
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        double price = Double.parseDouble(request.getParameter("price"));
        int seats = Integer.parseInt(request.getParameter("seats"));
        LocalDate departureDate = LocalDate.parse(request.getParameter("departureDate"));
        boolean active = request.getParameter("active") != null;
        String image = request.getParameter("image");
        int destinationId = Integer.parseInt(request.getParameter("destinationId"));

        //Creamos el objeto Trip
        Trip newTrip = new Trip(0, title, description, country, city, price, seats, departureDate, active, image, destinationId);

        //Conectamos a la base de datos y guardamos
        try {
            Database.connect();
            TripDao tripDao = Database.jdbi.onDemand(TripDao.class);
            tripDao.addTrip(newTrip);
        } catch (ClassNotFoundException e) {
            throw new ServletException("Database driver error", e);
        }

        //Redirigimos al inicio para ver la tarjeta del nuevo viaje
        response.sendRedirect("index.jsp");
    }
}
