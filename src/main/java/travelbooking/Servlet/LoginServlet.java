package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import travelbooking.dao.Database;
import travelbooking.dao.UserDao;
import travelbooking.model.User;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Recoger parámetros del formulario
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //Conectar a la base de datos y buscar al usuario
        UserDao userDao = Database.jdbi.onDemand(UserDao.class);
        User user = userDao.getByEmailAndPassword(email, password);

        //Comprobar si el usuario existe
        if (user != null) {
            //Guardamos el usuario en sesión usando la clave "user"
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirigir a la página principal
            response.sendRedirect("index.jsp");
        } else {
            //Redirigir de vuelta al login indicando error en la URL
            response.sendRedirect("login.jsp?error=true");
        }
    }
}
