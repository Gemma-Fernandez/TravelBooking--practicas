package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import travelbooking.dao.Database;
import travelbooking.dao.TripDao;
import travelbooking.model.Trip;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;


@WebServlet("/addTrip")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10       // 10MB máximo por foto
)
public class AddTripServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Recogemos los textos normales
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String country = request.getParameter("country");
        String city = request.getParameter("city");
        double price = Double.parseDouble(request.getParameter("price"));
        int seats = Integer.parseInt(request.getParameter("seats"));
        LocalDate departureDate = LocalDate.parse(request.getParameter("departureDate"));
        boolean active = request.getParameter("active") != null;
        int destinationId = Integer.parseInt(request.getParameter("destinationId"));

        //LÓGICA DE SUBIDA DE IMAGEN
        Part filePart = request.getPart("imageFile");
        String fileName = filePart.getSubmittedFileName();

        // Si admin no sube foto, evitamos que rompa poniendo una cadena vacía
        if (fileName == null || fileName.isEmpty()) {
            fileName = "";
        } else {
            // Buscamos la ruta temporal donde Tomcat está ejecutando tu app web
            String uploadPath = getServletContext().getRealPath("") + File.separator + "images";

            // Si la carpeta "images" no existe ahí, la creamos
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            //Guardamos físicamente el archivo en el disco duro del servidor
            filePart.write(uploadPath + File.separator + fileName);
        }

        //Creamos el viaje pasándole el nombre del archivo que hemos guardar
        Trip newTrip = new Trip(0, title, description, country, city, price, seats, departureDate, active, fileName, destinationId);

        // 4. Guardamos en la base de datos
        try {
            Database.connect();
            TripDao tripDao = Database.jdbi.onDemand(TripDao.class);
            tripDao.addTrip(newTrip);
        } catch (ClassNotFoundException e) {
            throw new ServletException("Database driver error", e);
        }

        response.sendRedirect("index.jsp");
    }
}