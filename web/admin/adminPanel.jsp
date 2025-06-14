<%-- 
    Document   : adminPanel
    Created on : Jun 13, 2025, 9:32:42 AM
    Author     : ellaa
--%>

<%@ page import="java.util.*, tasktrack.models.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Panel</title>
        <style>
            table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
            th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
            .section { margin-bottom: 50px; }
            .actions { margin-top: 10px; }
        </style>
    </head>
    <body>
        <h1>Admin Panel</h1>
        <a href="logout">Logout</a>

        <div class="section">
            <h2>Student Progress</h2>
            <table>
                <tr><th>Name</th><th>Courses Taken</th><th>Assignments Completed</th></tr>
                <c:forEach var="student" items="${students}">
                    <tr>
                        <td>${student.name}</td>
                        <td>${student.courseCount}</td>
                        <td>${student.assignmentsCompleted}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <div class="section">
            <h2>Course Management</h2>
            <a href="courseForm.jsp">Add Course</a>
            <table>
                <tr><th>Name</th><th>Description</th><th>Actions</th></tr>
                <c:forEach var="course" items="${courses}">
                    <tr>
                        <td>${course.name}</td>
                        <td>${course.description}</td>
                        <td>
                            <form method="get" action="courseForm.jsp" style="display:inline">
                                <input type="hidden" name="id" value="${course.id}" />
                                <button type="submit">Edit</button>
                            </form>
                            <form method="post" action="courseManagement">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="id" value="${course.id}" />
                                <button type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <div class="section">
            <h2>Assignment Management</h2>
            <a href="assignmentForm.jsp">Add Assignment</a>
            <table>
                <tr><th>Title</th><th>Deadline</th><th>Course</th><th>Actions</th></tr>
                <c:forEach var="assignment" items="${assignments}">
                    <tr>
                        <td>${assignment.title}</td>
                        <td>${assignment.deadline}</td>
                        <td>${assignment.courseName}</td>
                        <td>
                            <form method="get" action="assignmentForm.jsp" style="display:inline">
                                <input type="hidden" name="id" value="${assignment.id}" />
                                <button type="submit">Edit</button>
                            </form>
                            <form method="post" action="assignmentManagement">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="id" value="${assignment.id}" />
                                <button type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <div class="section">
            <h2>Assign Role</h2>
            <form method="post" action="assignRole">
                <label>Email: <input type="email" name="email" required></label>
                <label>Password: <input type="password" name="password" required></label>
                <button type="submit">Assign Role</button>
            </form>
        </div>
    </body>
</html>
