package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import travelbooking.dao.Database;
import travelbooking.dao.TripDao;
import travelbooking.model.User;

import java.io.IOException;

@WebServlet("/deleteTrip")
public class DeleteTripServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //Comprobar que hay sesión y es ADMIN
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null && "ADMIN".equals(user.getRole())) {

            //Recoger el ID de la URL
            int id = Integer.parseInt(request.getParameter("id"));

            //Conectar a la base de datos de forma segura
            try {
                Database.connect();
            } catch (ClassNotFoundException e) {
                throw new ServletException("Error al cargar la base de datos", e);
            }

            //Ejecutar el borrado a través del DAO
            TripDao tripDao = Database.jdbi.onDemand(TripDao.class);
            tripDao.deleteTrip(id);
        }

        //redirigir al menú principal
        response.sendRedirect("index.jsp");
    }
}
