<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <!--TailwindCSS CDN-->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-100 text-gray-800">

    <div class="max-w-5xl mx-auto p-6">
        <h1 class="text-3xl font-bold text-indigo-500 mb-2">Welcome, ${student.name}</h1>
        <p class="mb-4 text-lg">Level: <span class="font-semibold">${student.level}</span></p>
        <a href="/TaskTrack/logout" class="inline-block bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 mb-8">Logout</a>

        <h2 class="text-2xl font-semibold text-indigo-500 mb-4">To‑Do List</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white shadow rounded mb-6">
                <thead>
                    <tr class="bg-indigo-500 text-white">
                        <th class="px-4 py-2 text-left">Title</th>
                        <th class="px-4 py-2 text-left">Course</th>
                        <th class="px-4 py-2 text-left">Deadline</th>
                        <th class="px-4 py-2 text-left">Status</th>
                        <th class="px-4 py-2 text-left">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${assignments}">
                        <tr class="border-b">
                            <td class="px-4 py-2">${a.title}</td>
                            <td class="px-4 py-2">${a.courseName}</td>
                            <td class="px-4 py-2">
                                <fmt:formatDate value="${a.deadline}" pattern="dd-MM-yyyy" />
                            </td>

                            <td class="px-4 py-2 font-semibold
                                ${a.status == 'Done' ? 'text-green-600' : 'text-gray-500'}">
                                ${a.status}
                            </td>

                            <td class="px-4 py-2">
                                <form method="post" action="${pageContext.request.contextPath}/updateAssignmentStatus" class="flex items-center gap-2">
                                    <input type="hidden" name="assignmentId" value="${a.id}"/>
                                    <select name="status" class="border rounded px-2 py-1">
                                        <option value="Pending" ${a.status=="Pending"?"selected":""}>Pending</option>
                                        <option value="Done" ${a.status=="Done"?"selected":""}>Done</option>
                                    </select>
                                    <button type="submit" class="bg-indigo-500 text-white px-3 py-1 rounded hover:bg-indigo-600">Update</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>

            </table>
        </div>
        <c:if test="${empty assignments}">
            <p class="text-gray-500 italic mb-6">No assignments available.</p>
        </c:if>

        <h2 class="text-2xl font-semibold text-indigo-500 mb-4">Courses Taken</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white shadow rounded mb-6">
                <thead>
                    <tr class="bg-indigo-500 text-white">
                        <th class="px-4 py-2 text-left">Name</th>
                        <th class="px-4 py-2 text-left">Description</th>
                        <th class="px-4 py-2 text-left">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${enrolled}">
                        <tr class="border-b">
                            <td class="px-4 py-2">${c.name}</td>
                            <td class="px-4 py-2">${c.description}</td>
                            <td class="px-4 py-2 text-green-600 font-medium">Enrolled</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${empty enrolled}">
            <p class="text-gray-500 italic mb-6">No courses enrolled.</p>
        </c:if>

        <a href="${pageContext.request.contextPath}/enroll" class="inline-block bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600">
            Enroll New Course
        </a>
    </div>

</body>
</html>
