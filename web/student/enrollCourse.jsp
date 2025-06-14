<%-- 
    Document   : enrollCourse
    Created on : Jun 13, 2025, 9:34:38 AM
    Author     : ellaa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Enroll Course</title>
    </head>
    <body>
        <h2>Enroll Course</h2>
        <table border="1"><tr><th>Name</th><th>Description</th><th>Action</th></tr>
        <c:forEach var="course" items="${courses}">
          <tr><td>${course.name}</td><td>${course.description}</td>
            <td>
              <c:choose>
                <c:when test="${course.enrolled}">
                  Already Enrolled
                </c:when>
                <c:otherwise>
                  <form method="post" action="enroll">
                    <input type="hidden" name="courseId" value="${course.id}"/>
                    <button type="submit">Enroll</button>
                  </form>
                </c:otherwise>
              </c:choose>
            </td></tr>
        </c:forEach>
        </table>
        <a href="student">Back to Dashboard</a>
    </body>
</html>