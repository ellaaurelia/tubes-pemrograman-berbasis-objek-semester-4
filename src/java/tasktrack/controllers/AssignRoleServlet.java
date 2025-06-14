package tasktrack.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet(name = "AssignRoleServlet", urlPatterns = {"/assignRole"})
public class AssignRoleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("user_id"));
        String action = req.getParameter("action");

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tasktrack", "root", "")) {
            if ("promote".equals(action)) {
                PreparedStatement promote = conn.prepareStatement("UPDATE user SET role='admin', email=CONCAT('admin', email) WHERE id=?");
                promote.setInt(1, userId);
                promote.executeUpdate();

                PreparedStatement insertAdmin = conn.prepareStatement("INSERT INTO admin (id) VALUES (?)");
                insertAdmin.setInt(1, userId);
                insertAdmin.executeUpdate();
            } else if ("demote".equals(action)) {
                PreparedStatement demote = conn.prepareStatement("UPDATE user SET role='student', email=REPLACE(email, 'admin', '') WHERE id=?");
                demote.setInt(1, userId);
                demote.executeUpdate();

                PreparedStatement deleteAdmin = conn.prepareStatement("DELETE FROM admin WHERE id=?");
                deleteAdmin.setInt(1, userId);
                deleteAdmin.executeUpdate();
            }
            resp.sendRedirect("admin");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
