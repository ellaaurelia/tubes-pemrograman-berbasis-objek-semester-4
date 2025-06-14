<%-- 
    Document   : assignRole
    Created on : Jun 13, 2025, 9:33:51 AM
    Author     : ellaa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Assign Role</title>
    </head>
    <body>
        <h2>Assign New Admin Role</h2>

        <form action="assignRole" method="post">
            <label for="email">Student Email:</label><br>
            <input type="email" id="email" name="email" required><br><br>

            <label for="password">New Admin Password:</label><br>
            <input type="password" id="password" name="password" required><br><br>

            <button type="submit">Create Admin</button>
        </form>

        <c:if test="${not empty message}">
            <p style="color:green;">${message}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color:red;">${error}</p>
        </c:if>

        <a href="adminPanel.jsp">Back to Admin Panel</a>
    </body>
</html>