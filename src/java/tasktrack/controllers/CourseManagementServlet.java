package tasktrack.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet(name = "CourseManagementServlet", urlPatterns = {"/courseManagement"})
public class CourseManagementServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String desc = req.getParameter("description");
        boolean isDelete = "true".equals(req.getParameter("delete"));

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tasktrack", "root", "")) {
            PreparedStatement ps;
            if (isDelete) {
                ps = conn.prepareStatement("DELETE FROM course WHERE id = ?");
                ps.setInt(1, Integer.parseInt(id));
            } else if (id == null || id.isEmpty()) {
                ps = conn.prepareStatement("INSERT INTO course (name, description) VALUES (?, ?)");
                ps.setString(1, name);
                ps.setString(2, desc);
            } else {
                ps = conn.prepareStatement("UPDATE course SET name=?, description=? WHERE id=?");
                ps.setString(1, name);
                ps.setString(2, desc);
                ps.setInt(3, Integer.parseInt(id));
            }
            ps.executeUpdate();
            resp.sendRedirect("admin");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
