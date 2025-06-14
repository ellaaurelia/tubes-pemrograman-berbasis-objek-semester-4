package tasktrack.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

@WebServlet(name = "AdminPanelServlet", urlPatterns = {"/admin"})
public class AdminPanelServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/tasktrack", "root", "")) {
            List<Map<String, Object>> students = new ArrayList<>();
            List<Map<String, Object>> courses = new ArrayList<>();
            List<Map<String, Object>> assignments = new ArrayList<>();

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT u.id, u.name, COUNT(ce.course_id) AS courses, s.assignments_completed FROM user u JOIN student s ON u.id = s.id LEFT JOIN course_enrollments ce ON u.id = ce.student_id GROUP BY u.id, u.name, s.assignments_completed ORDER BY s.assignments_completed ASC");
            while (rs.next()) {
                Map<String, Object> student = new HashMap<>();
                student.put("id", rs.getInt("id"));
                student.put("name", rs.getString("name"));
                student.put("courses", rs.getInt("courses"));
                student.put("completed", rs.getInt("assignments_completed"));
                students.add(student);
            }

            rs = stmt.executeQuery("SELECT * FROM course");
            while (rs.next()) {
                Map<String, Object> course = new HashMap<>();
                course.put("id", rs.getInt("id"));
                course.put("name", rs.getString("name"));
                course.put("description", rs.getString("description"));
                courses.add(course);
            }

            rs = stmt.executeQuery("SELECT * FROM assignment");
            while (rs.next()) {
                Map<String, Object> a = new HashMap<>();
                a.put("id", rs.getInt("id"));
                a.put("title", rs.getString("title"));
                a.put("deadline", rs.getDate("deadline"));
                a.put("status", rs.getString("status"));
                a.put("course_id", rs.getInt("course_id"));
                assignments.add(a);
            }

            req.setAttribute("students", students);
            req.setAttribute("courses", courses);
            req.setAttribute("assignments", assignments);
            req.getRequestDispatcher("adminPanel.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
