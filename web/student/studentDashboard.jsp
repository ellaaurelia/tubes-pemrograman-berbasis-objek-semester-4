<%-- 
    Document   : studentDashboard.jsp
    Created on : Jun 13, 2025, 9:34:26 AM
    Author     : ellaa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Student Dashboard</title>
    </head>
    <body>
        <h1>Welcome, ${student.name}</h1>
        <a href="logout">Logout</a>

        <h2>To‑Do List (Page ${page} of ${totalPages})</h2>
        <table border="1">
          <tr>
              <th>Title</th>
              <th>Course</th>
              <th>Deadline</th>
              <th>Status</th>
              <th>Action</th></tr>
          <c:forEach var="a" items="${assignments}">
            <tr>
                <td>${a.title}</td>
                <td>${a.courseName}</td>
                <td>${a.deadline}</td>
                <td>${a.status}</td>
                <td>
                  <form method="post" action="updateAssignmentStatus">
                    <input type="hidden" name="assignmentId" value="${a.id}"/>
                    <select name="status">
                      <option value="Pending" ${a.status=="Pending"?"selected":""}>Pending</option>
                      <option value="Done" ${a.status=="Done"?"selected":""}>Done</option>
                    </select>
                    <button type="submit">Update</button>
                  </form>
                </td></tr>
          </c:forEach>
        </table>
        <c:if test="${page > 1}">
          <a href="student?page=${page -1}">Prev</a>
        </c:if>
        <c:if test="${page < totalPages}">
          <a href="student?page=${page +1}">Next</a>
        </c:if>

        <h2>Courses Taken (Page ${cpage} of ${ctotal})</h2>
        <table border="1">
          <tr>
              <th>Name</th>
              <th>Description</th>
              <th>Action</th>
          </tr>
          <c:forEach var="c" items="${enrolled}">
            <tr>
                <td>${c.name}</td>
                <td>${c.description}</td>
                <td>Enrolled</td>
            </tr>
          </c:forEach>
        </table>
        <c:if test="${cpage > 1}"><a href="student?cpage=${cpage-1}">Prev</a></c:if>
        <c:if test="${cpage < ctotal}"><a href="student?cpage=${cpage+1}">Next</a></c:if>

        <a href="enrollCourse.jsp">Enroll New Course</a>

    </body>
</html>