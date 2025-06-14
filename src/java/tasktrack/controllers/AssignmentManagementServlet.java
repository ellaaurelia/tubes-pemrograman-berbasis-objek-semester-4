package tasktrack.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet(name = "AssignmentManagementServlet", urlPatterns = {"/assignmentManagement"})
public class AssignmentManagementServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String title = req.getParameter("title");
        String deadline = req.getParameter("deadline");
        String courseId = req.getParameter("course_id");
        boolean isDelete = "true".equals(req.getParameter("delete"));

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tasktrack", "root", "")) {
            PreparedStatement ps;
            if (isDelete) {
                ps = conn.prepareStatement("DELETE FROM assignment WHERE id = ?");
                ps.setInt(1, Integer.parseInt(id));
            } else if (id == null || id.isEmpty()) {
                ps = conn.prepareStatement("INSERT INTO assignment (title, deadline, course_id) VALUES (?, ?, ?)");
                ps.setString(1, title);
                ps.setDate(2, Date.valueOf(deadline));
                ps.setInt(3, Integer.parseInt(courseId));
            } else {
                ps = conn.prepareStatement("UPDATE assignment SET title=?, deadline=?, course_id=? WHERE id=?");
                ps.setString(1, title);
                ps.setDate(2, Date.valueOf(deadline));
                ps.setInt(3, Integer.parseInt(courseId));
                ps.setInt(4, Integer.parseInt(id));
            }
            ps.executeUpdate();
            resp.sendRedirect("admin");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
