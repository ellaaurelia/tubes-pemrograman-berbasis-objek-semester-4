package tasktrack.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet(name = "EnrollCourseServlet", urlPatterns = {"/enroll"})
public class EnrollCourseServlet extends HttpServlet {
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/tasktrack", "root", "your_password");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        HttpSession session = request.getSession();
        int studentId = ((tasktrack.models.Student) session.getAttribute("user")).getId();

        try (Connection conn = getConnection()) {
            // Check apakah sudah enroll
            try (PreparedStatement check = conn.prepareStatement("SELECT * FROM course_enrollments WHERE student_id=? AND course_id=?")) {
                check.setInt(1, studentId);
                check.setInt(2, courseId);
                ResultSet rs = check.executeQuery();
                if (!rs.next()) {
                    try (PreparedStatement stmt = conn.prepareStatement("INSERT INTO course_enrollments (student_id, course_id) VALUES (?, ?)")) {
                        stmt.setInt(1, studentId);
                        stmt.setInt(2, courseId);
                        stmt.executeUpdate();
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("student");
    }
}
