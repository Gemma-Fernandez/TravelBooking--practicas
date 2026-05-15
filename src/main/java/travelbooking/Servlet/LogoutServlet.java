package travelbooking.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recuperar la sesión actual sin crear una nueva
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Destruir la sesión por completo
            session.invalidate();
        }

        // Volver a la página principal como visitante
        response.sendRedirect("index.jsp");
    }
}