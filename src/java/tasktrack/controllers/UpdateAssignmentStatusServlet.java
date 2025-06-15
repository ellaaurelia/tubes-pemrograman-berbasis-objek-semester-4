package tasktrack.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import tasktrack.models.Student;
import tasktrack.utils.DatabaseConnection;

@WebServlet(name = "UpdateAssignmentStatusServlet", urlPatterns = {"/updateAssignmentStatus"})
public class UpdateAssignmentStatusServlet extends HttpServlet {
    private Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
        String newStatus = request.getParameter("status");

        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("user");
        int studentId = student.getId();

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            
            try (PreparedStatement stmt = conn.prepareStatement("""
                SELECT level, assignments_completed FROM student WHERE id = ?
            """)) {
                stmt.setInt(1, studentId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        student.setLevel(rs.getInt("level"));
                        student.setAssignmentsCompleted(rs.getInt("assignments_completed"));
                    }
                }
            }

            boolean alreadyCompleted = false;

            try (PreparedStatement check = conn.prepareStatement("""
                SELECT ac.completed_at
                FROM assignment a
                LEFT JOIN assignment_completions ac ON a.id = ac.assignment_id AND ac.student_id = ?
                WHERE a.id = ?
            """)) {
                check.setInt(1, studentId);
                check.setInt(2, assignmentId);
                try (ResultSet rs = check.executeQuery()) {
                    if (rs.next()) {
                        alreadyCompleted = rs.getTimestamp("completed_at") != null;
                    }
                }
            }

            if (newStatus.equalsIgnoreCase("Done") && !alreadyCompleted) {
                try (PreparedStatement insert = conn.prepareStatement("""
                    INSERT INTO assignment_completions (student_id, assignment_id, completed_at)
                    VALUES (?, ?, NOW())
                """)) {
                    insert.setInt(1, studentId);
                    insert.setInt(2, assignmentId);
                    insert.executeUpdate();
                }

            } else if (newStatus.equalsIgnoreCase("Pending") && alreadyCompleted) {
                try (PreparedStatement delete = conn.prepareStatement("""
                    DELETE FROM assignment_completions WHERE student_id = ? AND assignment_id = ?
                """)) {
                    delete.setInt(1, studentId);
                    delete.setInt(2, assignmentId);
                    delete.executeUpdate();
                }
            }

            int completed = 0;
            try (PreparedStatement count = conn.prepareStatement("""
                SELECT COUNT(*) AS total FROM assignment_completions WHERE student_id = ?
            """)) {
                count.setInt(1, studentId);
                try (ResultSet rs = count.executeQuery()) {
                    if (rs.next()) {
                        completed = rs.getInt("total");
                    }
                }
            }

            int level = Math.max(1, completed / 5 + 1);

            student.setAssignmentsCompleted(completed);
            student.setLevel(level);
            session.setAttribute("user", student);

            try (PreparedStatement update = conn.prepareStatement("""
                UPDATE student SET level = ?, assignments_completed = ? WHERE id = ?
            """)) {
                update.setInt(1, level);
                update.setInt(2, completed);
                update.setInt(3, studentId);
                update.executeUpdate();
            }

            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/student");
    }
}
