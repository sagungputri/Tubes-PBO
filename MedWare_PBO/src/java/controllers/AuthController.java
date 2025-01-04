package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Admin;
import models.User;

@WebServlet(name = "AuthController", urlPatterns = {"/AuthController"})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    HttpSession session = request.getSession();

    if ("admin".equals(username) && "1234".equals(password)) {
        Admin admin = new Admin(username);
        session.setAttribute("user", admin);
        response.sendRedirect(request.getContextPath() + "/product?menu=view");
    } else if ("user".equals(username) && "1234".equals(password)) {
        User user = new User(username);
        session.setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/product?menu=view");
    } else {
        response.sendRedirect(request.getContextPath() + "/index.jsp?error=1");
    }
}


    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
