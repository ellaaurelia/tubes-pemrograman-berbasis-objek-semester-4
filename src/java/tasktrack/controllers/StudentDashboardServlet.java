package tasktrack.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import tasktrack.models.*;

@WebServlet(name = "StudentDashboardServlet", urlPatterns = {"/student"})
public class StudentDashboardServlet extends HttpServlet {

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/tasktrack", "root", "your_password");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("user");

        if (student == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = student.getId();
        int page = Integer.parseInt(Optional.ofNullable(request.getParameter("page")).orElse("1"));
        int cpage = Integer.parseInt(Optional.ofNullable(request.getParameter("cpage")).orElse("1"));
        int limit = 10;
        int offset = (page - 1) * limit;
        int coffset = (cpage - 1) * limit;

        List<Map<String, Object>> assignments = new ArrayList<>();
        List<Map<String, Object>> courses = new ArrayList<>();
        int totalAssignments = 0;
        int totalCourses = 0;

        try (Connection conn = getConnection()) {

            String queryAssignments = """
                SELECT a.id, a.title, a.deadline, c.name AS course_name,
                       ac.completed_at
                FROM assignment a
                JOIN course c ON a.course_id = c.id
                JOIN course_enrollments ce ON c.id = ce.course_id
                LEFT JOIN assignment_completions ac ON a.id = ac.assignment_id AND ac.student_id = ?
                WHERE ce.student_id = ?
                ORDER BY a.deadline ASC
                LIMIT ? OFFSET ?
            """;

            try (PreparedStatement ps = conn.prepareStatement(queryAssignments)) {
                ps.setInt(1, studentId);
                ps.setInt(2, studentId);
                ps.setInt(3, limit);
                ps.setInt(4, offset);

                try (ResultSet rs = ps.executeQuery()) {
                    java.util.Date now = new java.util.Date();

                    while (rs.next()) {
                        java.util.Date deadline = rs.getDate("deadline");
                        Timestamp completedAt = rs.getTimestamp("completed_at");

                        String status;
                        if (completedAt != null) {
                            status = "Done";
                        } else if (deadline.before(now)) {
                            Calendar cal = Calendar.getInstance();
                            cal.setTime(deadline);
                            cal.add(Calendar.DAY_OF_MONTH, 7);
                            if (now.after(cal.getTime())) {
                                continue;
                            }
                            status = "Late";
                        } else {
                            status = "Pending";
                        }

                        Map<String, Object> a = new HashMap<>();
                        a.put("id", rs.getInt("id"));
                        a.put("title", rs.getString("title"));
                        a.put("deadline", deadline);
                        a.put("courseName", rs.getString("course_name"));
                        a.put("status", status);

                        assignments.add(a);
                    }
                }
            }

            try (PreparedStatement countStmt = conn.prepareStatement("""
                SELECT COUNT(*) FROM assignment a
                JOIN course_enrollments ce ON a.course_id = ce.course_id
                WHERE ce.student_id = ?
            """)) {
                countStmt.setInt(1, studentId);
                try (ResultSet rs = countStmt.executeQuery()) {
                    if (rs.next()) totalAssignments = rs.getInt(1);
                }
            }

            String queryCourses = """
                SELECT c.id, c.name, c.description
                FROM course c
                JOIN course_enrollments ce ON c.id = ce.course_id
                WHERE ce.student_id = ?
                LIMIT ? OFFSET ?
            """;

            try (PreparedStatement ps = conn.prepareStatement(queryCourses)) {
                ps.setInt(1, studentId);
                ps.setInt(2, limit);
                ps.setInt(3, coffset);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> c = new HashMap<>();
                        c.put("id", rs.getInt("id"));
                        c.put("name", rs.getString("name"));
                        c.put("description", rs.getString("description"));
                        courses.add(c);
                    }
                }
            }

            try (PreparedStatement countStmt = conn.prepareStatement("""
                SELECT COUNT(*) FROM course_enrollments WHERE student_id = ?
            """)) {
                countStmt.setInt(1, studentId);
                try (ResultSet rs = countStmt.executeQuery()) {
                    if (rs.next()) totalCourses = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("student", student);
        request.setAttribute("assignments", assignments);
        request.setAttribute("enrolled", courses);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", (int) Math.ceil(totalAssignments / 10.0));
        request.setAttribute("cpage", cpage);
        request.setAttribute("ctotal", (int) Math.ceil(totalCourses / 10.0));
        request.getRequestDispatcher("studentDashboard.jsp").forward(request, response);
    }
}
